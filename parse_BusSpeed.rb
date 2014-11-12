require "json"

varCount = 0
varSum = 0 
varAvg = 0

fname = "CAT Parse #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"
somefile = File.open(fname, "w")
# Paste your string below
string = <string>
payload = string[/{.+}/]
data_hash = JSON.parse(payload)

data_hash["data"]["20"].each do |ary|
varSpd = ary["speed"]
somefile.puts varSpd
varCount = varCount + 1
varSum = varSum + ary["speed"]
end
somefile.puts ""
somefile.puts "Count"
somefile.puts varCount

somefile.puts ""
somefile.puts "Sum"
somefile.puts varSum

somefile.puts ""
somefile.puts "Average MPH"
varAvg = varSum / varCount
somefile.puts varAvg

somefile.close
