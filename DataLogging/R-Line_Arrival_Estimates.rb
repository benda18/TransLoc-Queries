#A ruby script that does stuff

#To Do:
# 	1. show individual stops in dashboard x,y,z chart where x/y = lon/lat and Z = average wait. 

require 'json'
require 'unirest'
require 'time'
require 'date'
require 'csv'
puts "\e[H\e[2J"


#stopsCACHE
#varTrack = 0
stname = "stopsCache.txt"
stopsfile = File.open(stname, "w")
data_hashs = 0
payloads = 0
payload2s = 0
varSIDs = 0
varLNGs = 0
varLATs = 0
varCTs = 0
varNAMs = 0
varCsid = 0
# These code snippets use an open-source library. http://unirest.io/ruby
responseS = Unirest.get "https://transloc-api-1-2.p.mashape.com/stops.jsonp?agencies=20&callback=call",
  headers:{
    "X-Mashape-Key" => "<key>"
  }
payload2s = responseS.body					#sets the call response body as a variable
payloads = payload2s[/{.+}/]					#removes the callback prefix and suffix from the response body
data_hashs = JSON.parse(payloads)				#parses the response body and stores as a variable
stopsfile = File.open(stname, "w")
stopsfile.puts "stop_id,lng,lat,name"
Array(data_hashs["data"]).each do |aryS|
varCTs +=  1;
varSIDs = 0
varLNGs = 0
varLATs = 0
varNAMs = 0
varSIDs = aryS["stop_id"]
varLNGs = aryS["location"]["lng"]
varLATs = aryS["location"]["lat"]
varNAMs = aryS["name"]
stopsfile.puts "#{varSIDs},#{varLNGs},#{varLATs},#{varNAMs}"
end
stopsfile.close
data_hashs = 0
payloads = 0
payload2s = 0
varSIDs = 0
varLNGs = 0
varLATs = 0
varCTs = 0
varNAMs = 0
#/stopsCACHE



cacheA = "cacheA.txt" 
cacheB = "cacheB.txt"
cacheC = "cacheC.txt"
dash = "WaitDash.html"

aname = "R-LineAvgStopWait #{Time.now.strftime('%Y%m%d')}.txt"
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
varNum = 900								#loop iterations
d = 30										#loop delay seconds
varWaitCum = 0
varWaitCount = 0
varLat = 0
varLng = 0
varName = 0


File.open(cacheA, "w") do |a1|
	a1.puts "<html>"
	a1.puts "<head>"
	a1.puts "#{"<META HTTP-EQUIV="}#{'"'}#{"refresh"}#{'"'}#{" CONTENT="}#{'"'}#{30}#{'"'}#{">"}"#refresh code
	a1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
	a1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
	a1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"
	a1.puts "google.setOnLoadCallback(drawChart3);"
	a1.puts "function drawChart3() {"
	a1.puts "var data3 = google.visualization.arrayToDataTable(["
	a1.puts "['Route','Wait in Minutes'],"
end



if not File.exists?(aname)						#only writes header to fname if the file doesn't already exists.  
File.open(aname, "a+") do |f1|
	f1.puts "gendate,agency,route,stop_id,MinsToArriv,lon,lat,name"
end
end

begin
# These code snippets use an open-source library. http://unirest.io/ruby
#response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032&stops=4105778",
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032",
  headers:{
    "X-Mashape-Key" => "<key>"
  }

payload2 = response.body					#sets the call response body as a variable
payload = payload2[/{.+}/]					#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)				#parses the response body and stores as a variable

varI +=1;
puts "\e[H\e[2J"
puts "#{varI} of #{varNum}"
puts ""
puts "#{d} second delay"
varGenTime = data_hash["generated_on"]


Array(data_hash["data"]).each do |ary3|
varAgc = ary3.fetch("agency_id")
varSid = ary3.fetch("stop_id")

#PARSE CSV stopsCACHE
CSV.foreach(stname, :headers => true) do |aryS2|

varCsid = aryS2["stop_id"]
if varCsid == varSid 
varLat = aryS2["lat"]
varLng = aryS2["lng"]
varName = aryS2["name"]
#varTrack += 1;
#puts "hellyeah #{varTrack}"
#sleep(0.1)
#else
#puts "boo #{varTrack}"
end
end

#/PARSE CSV stopsCACHE

varArr = ary3.fetch("arrivals").first.fetch("arrival_at")
varRid = ary3.fetch("arrivals").first.fetch("route_id")
varWaitMins = (Time.parse(varArr) - Time.parse(varGenTime))/60

varWaitCum = varWaitCum + varWaitMins
varWaitCount +=1;
varRtAvgWait = varWaitCum / varWaitCount

File.open(cacheC, "w") do |b1|
	b1.puts "]);"
	b1.puts "var options3 = {"
	b1.puts "title: 'Distribution of Estimated Wait Time for Next Bus Arrival Across All R-Line Stops',"
	b1.puts "legend: { position: 'right' },"
	b1.puts "histogram: { bucketSize: 1 },"
	b1.puts "isStacked: ['True']"
	b1.puts "};"
	b1.puts "var chart3 = new google.visualization.Histogram(document.getElementById('chart_div3'));"
	b1.puts "chart3.draw(data3, options3);"
	b1.puts "}"
	b1.puts "</script>"
	b1.puts "</head>"
	b1.puts "<body>"
	b1.puts "<style>"
	b1.puts "</style>"
	b1.puts "<section>"
	b1.puts "#{"<div id="}#{'"'}#{"chart_div3"}#{'"'}#{" style="}#{'"'}#{"width: 900px; height: 300px;"}#{'"'}#{"></div>"}"
	b1.puts "</section>"
	b1.puts "</body>"
	b1.puts "</html>"
	b1.puts "Average Wait: #{varRtAvgWait.round(1)} mins"
end


puts "#{varGenTime},#{varAgc},#{varRid},#{varSid},#{varWaitMins.round(1)},#{varLng},#{varLat},#{varName}"

File.open(aname, "a+") do |f2|
	f2.puts "#{varGenTime},#{varAgc},#{varRid},#{varSid},#{varWaitMins},#{varLng},#{varLat},#{varName}"
end

varLng = 0
varLat = 0
varName = 0


File.open(cacheB, "a+") do |b1|
	b1.puts "['R-Line',#{varWaitMins}],"
end

end

File.open(dash, "w+") do |zz1|
zz1.puts ""
end

hafile = File.open(cacheA, "r")
hacontents = hafile.read
hafile.close
File.open(dash, "a+") do |ha3|
ha3.puts hacontents
end
hbfile = File.open(cacheB, "r")
hbcontents = hbfile.read
hbfile.close
File.open(dash, "a+") do |ha4|
ha4.puts hbcontents
end
hcfile = File.open(cacheC, "r")
hccontents = hcfile.read
hcfile.close
File.open(dash, "a+") do |ha5|
ha5.puts hccontents
end 
sleep(d)
end until varI > varNum

File.delete(cacheA)
File.delete(cacheB)
File.delete(cacheC)
File.delete(stname)
puts "done"
