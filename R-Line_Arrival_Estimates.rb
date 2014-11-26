require 'json'
require 'unirest'
require 'time'
require 'date'

puts "\e[H\e[2J"

aname = "R-LineAvgStopWait #{Time.now.strftime('%Y%m%d')}.txt"
#somefile = File.open(aname, "w+")
payload = 0
payload2 = 0
data_hash = 0
status = 0
varSid = 0
tg = 0
tn = 0
td = 0
varAgc = 0
varRid = 0
varArr = 0
varGenTime = 0
varWaitMins = 0
varI = 0
varNum = 120								#loop iterations
d = 60										#loop delay seconds

if not File.exists?(aname)						#only writes header to fname if the file doesn't already exists.  
File.open(aname, "a+") do |f1|
	f1.puts "gendate,agency,route,stop_id,MinsToArriv"
end
end

# These code snippets use an open-source library. http://unirest.io/ruby
#response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032&stops=4105778",
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032",
  headers:{
    "X-Mashape-Key" => "<key>"
  }

payload2 = response.body					#sets the call response body as a variable
payload = payload2[/{.+}/]					#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)				#parses the response body and stores as a variable

begin
varI +=1;
puts "\e[H\e[2J"
puts "#{varI} of #{varNum}"
puts ""
puts "#{d} second delay"
varGenTime = data_hash["generated_on"]
Array(data_hash["data"]).each do |ary3|
varAgc = ary3.fetch("agency_id")
varSid = ary3.fetch("stop_id")
varArr = ary3.fetch("arrivals").first.fetch("arrival_at")
varRid = ary3.fetch("arrivals").first.fetch("route_id")
varWaitMins = (Time.parse(varArr) - Time.parse(varGenTime))/60

puts "#{varGenTime},#{varAgc},#{varRid},#{varSid},#{varWaitMins.round(1)}}"

File.open(aname, "a+") do |f2|
	f2.puts "#{varGenTime},#{varAgc},#{varRid},#{varSid},#{varWaitMins}"
end
end

sleep(d)
end until varI > varNum


puts "done"
