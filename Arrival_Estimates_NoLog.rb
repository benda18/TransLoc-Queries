#A ruby script that shows a dashboard of average wait time for next bus but logs nothing. 
#To Do:
# 	1.

require 'json'
require 'unirest'
require 'time'
require 'date'
require 'csv'
puts "\e[H\e[2J"
cacheA = "cacheA.txt"
cacheB = "cacheB.txt"
cacheC = "cacheC.txt"
dash = "WaitDash.html"

payload = 0
payload2 = 0
data_hash = 0
varArr = 0
varGenTime = 0
varWaitMins = 0
varI = 0
varNum = 10								#loop iterations
d = 3										#loop delay seconds
varWaitCum = 0
varWaitCount = 0
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

#sleep(2)
begin
# These code snippets use an open-source library. http://unirest.io/ruby
#response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call&routes=4000032&stops=4105778",
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/arrival-estimates.jsonp?agencies=20&callback=call",
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
varArr = ary3.fetch("arrivals").first.fetch("arrival_at")
varWaitMins = (Time.parse(varArr) - Time.parse(varGenTime))/60
varWaitCum = varWaitCum + varWaitMins
varWaitCount +=1;
varRtAvgWait = varWaitCum / varWaitCount
File.open(cacheC, "w") do |b1|
	b1.puts "]);"
	b1.puts "var options3 = {"
	b1.puts "title: 'Distribution of Estimated Wait Time for Next Bus Arrival Across Queried Bus Stops',"
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

File.open(cacheB, "a+") do |b1|
	b1.puts "['',#{varWaitMins.round(1)}],"
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
varGenTime = 0
end until varI > varNum
File.delete(cacheA)
File.delete(cacheB)
File.delete(cacheC)
#File.delete(stname)
#File.delete(RCname)
puts "done"
