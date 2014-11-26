require 'json'
require 'unirest'
require 'time'
require 'date'

puts "\e[H\e[2J"

aname = "Aest #{Time.now.strftime('%Y%m%d')}.txt"
somefile = File.open(aname, "w+")
payload = 0
payload2 = 0
data_hash = 0
status = 0
varSid = 0
tg = 0
tn = 0
td = 0


# These code snippets use an open-source library. http://unirest.io/ruby
#response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032&stops=4105778",
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032",
  headers:{
    "X-Mashape-Key" => "<key>"
  }

payload2 = response.body					#sets the call response body as a variable
payload = payload2[/{.+}/]					#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)				#parses the response body and stores as a variable

varGenTime = data_hash["generated_on"]

#status = data_hash.fetch("data")[0].fetch("arrivals")#[0].fetch("arrival_at")

data_hash["data"].each do |ary3|
varSid = ary3.fetch("stop_id")
varArr = ary3.fetch("arrivals").first.fetch("arrival_at")
varWaitSecs = (Time.parse(varArr) - Time.parse(varGenTime))/60
puts "#{varSid} #{varArr} ... #{varWaitSecs.round(2)}"
sleep(0.1)
end

somefile.puts data_hash#["data"]
#somefile.puts status

#tg = Time.parse(varGenTime)
tg = Time.now
sleep(1)
tn = Time.now

td = tn - tg

puts ""
puts "Now: #{tn}"
puts "Gen: #{tg}"
puts "Dif: #{td}"
puts "done"
