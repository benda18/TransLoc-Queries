require 'unirest'
require 'json'

varCount = 0
varSum = 0 
varAvg = 0

fname = "CAT Parse #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"
somefile = File.open(fname, "w")

response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=call",
  headers:{
    "X-Mashape-Key" => "5SA6zZbMxpmshjhL0Y8ERCZ2WqnIp1zgKOmjsnXy5WDKmZaGC4"
  }

payload2 = response.body
payload = payload2[/{.+}/]
data_hash = JSON.parse(payload)

data_hash["data"]["20"].each do |ary|
varSpd = ary["speed"]
#somefile.puts varSpd
varCount = varCount + 1
varSum = varSum + ary["speed"]
end
somefile.puts ""
somefile.puts "Number of Buses"
somefile.puts varCount

#somefile.puts ""
#somefile.puts "Sum"
#somefile.puts varSum

somefile.puts ""
somefile.puts "Average MPH"
varAvg = varSum / varCount
somefile.puts varAvg.round(1)

somefile.close