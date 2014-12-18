# A script that shows how many buses are within a given radius
# of the user at that particular moment in time. 
#
#--PROCESS--
#
#-----------------------------
# 2. Get my location (lon/lat)
#-----------------------------
# 4. Query vehicles 
#-----------------------------
# 4. Calculate distance from  me to every vehicle
#-----------------------------
# 5. Histogram
#-----------------------------
#
#--REQUIRE-STATEMENTS--
require 'unirest'
require 'json'
require 'time'
require 'date'
#require 'socket'
#
#--VARS--
hfull = "DistributionOfBusesNearMe.html"
haname = "dashcacheA100.txt"			#data
hbname = "dashcacheB100.txt"			#data
hcname = "dashcacheC100.txt"			#data
varGenTime = 0							#time of response
varDate = 0
varHour = 0
varMin = 0
varXTime = 0							#time value for x axis in scatter chart
dNearest = 9999							#record nearest bus - SET HIGH up front and reduce
dCache = 0
d = 0
File.open(haname, "w+") do |ha1|
	ha1.puts "<html>"
	ha1.puts Time.now
	ha1.puts "<head>"
	#if varI < varNum
	ha1.puts "#{"<META HTTP-EQUIV="}#{'"'}#{"refresh"}#{'"'}#{" CONTENT="}#{'"'}#{30}#{'"'}#{">"}"#refresh code
	#end
	ha1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
#historgram
	ha1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"		#<script type="text/javascript">
	ha1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"	# google.load("visualization", "1", {packages:["corechart"]});
	ha1.puts "#{"google.setOnLoadCallback(drawChart);"}"					# google.setOnLoadCallback(drawChart3);
	ha1.puts "#{"function drawChart() {"}"									# function drawChart3() {
	ha1.puts "#{"var data = google.visualization.arrayToDataTable(["}"		# var data3 = google.visualization.arrayToDataTable([	
	ha1.puts "#{"['ID', 'Time', 'Miles', 'Color', 'Count'],"}"										# "['#{varXTime}', '#{d}'],"
end
=begin
File.open(hbname, "w+") do |zz2|										#starts hbname over as a blank file each launch. 
zz2.puts ""
end
=end

puts "\e[H\e[2J"
def power(num, pow)
num ** pow
end
#
#--MY-LOCATION--
varmyLng = -78.637277
varmyLat = 35.777531
#
#--VEHICLE-QUERY--
response = 0
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=GET",
  headers:{
    "X-Mashape-Key" => "<key>"
  }
payload2 = response.body
payload = payload2[/{.+}/]
data_hash = JSON.parse(payload)
varVct = 0
varGenTime = data_hash["generated_on"]
varDate = DateTime.parse(varGenTime)
varDate = varDate.to_time.iso8601
varDate = DateTime.parse(varDate)
varHour = varDate.hour.to_f
varMin = varDate.minute.to_f
varXTime = varHour + (varMin / 60)
Array(data_hash["data"]["20"]).each do |block|
varLat = 0
varLng = 0
varLat = block["location"]["lat"]
varLng = block["location"]["lng"]
#
#--calc-distance--
dtor = Math::PI/180
r = 3959
rlat1 = varmyLat * dtor 
rlong1 = varmyLng * dtor 
rlat2 = varLat * dtor 
rlong2 = varLng * dtor 
dlon = rlong1 - rlong2
dlat = rlat1 - rlat2
a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
d = r * c
#
#--STORE-NEAREST-BUS--
dCache = d 						#temp cache distance for "nearest" calcs
if dCache < dNearest
dNearest = dCache					#record nearest bus
end
#puts d.round(2)
#puts dNearest
#

if d < 0.250
varVct += 1
end
end
File.open(hbname, "a+") do |hb1|
	hb1.puts "#{"['',"}#{varXTime}, #{dNearest}, 'foo', #{varVct}#{"],"}"				#[time,distance] ---> # "[#{varXTime}, #{dNearest}],"
end

File.open(hcname, "w+") do |hc1|
	hc1.puts "#{"]);"}"
	hc1.puts "#{"var options = {"}"								# var options3 = {	
	hc1.puts "#{"title: 'Distance to Nearest Bus by Time-of-Day',"}"			# title: 'foo',
	hc1.puts "#{"hAxis: {title: 'Time of Day'},"}"
	hc1.puts "#{"vAxis: {title: 'Miles to Nearest Bus'},"}"
	#hc1.puts "#{"legend: 'none'"}"
	#hc1.puts "#{"histogram: { bucketSize: 0.25 },"}"
	#hc1.puts "#{"isStacked: ['True']"}"
	hc1.puts "#{"};"}"
	hc1.puts "#{"var chart = new google.visualization.BubbleChart(document.getElementById('series_chart_div'));"}"												# var chart2 = new google.visualization.BarChart(document.getElementById('chart_div2'));	
	hc1.puts "#{"chart.draw(data, options);"}"
	hc1.puts "#{"}"}"
	hc1.puts "#{"</script>"}"
	hc1.puts "#{"</head>"}"
	hc1.puts "#{"<body>"}"
	hc1.puts "#{"<div id="}#{'"'}#{"series_chart_div"}#{'"'}#{" style="}#{'"'}#{"width: 1800px; height: 800px;"}#{'"'}#{"></div>"}"
	hc1.puts "#{"<META HTTP-EQUIV="}#{'"'}#{"refresh"}#{'"'}#{" CONTENT="}#{'"'}#{30}#{'"'}#{">"}"#refresh code
	hc1.puts "<font size=#{'"'}30#{'"'} color=#{'"'}red#{'"'}><b>#{varVct}</b></font><br>"
	hc1.puts "buses within 1/4 mile"
	hc1.puts "#{"</body>"}"
	hc1.puts "#{"</html>"}"
end

#--CACHE-WORK--
File.open(hfull, "w+") do |zz1|
zz1.puts ""
end
hafile = File.open(haname, "r")
hacontents = hafile.read
hafile.close
File.open(hfull, "a+") do |ha3|
ha3.puts hacontents
end
hbfile = File.open(hbname, "r")
hbcontents = hbfile.read
hbfile.close
File.open(hfull, "a+") do |ha4|
ha4.puts hbcontents
end
hcfile = File.open(hcname, "r")
hccontents = hcfile.read
hcfile.close
File.open(hfull, "a+") do |ha5|
ha5.puts hccontents
end
#--CLEANUP--
File.delete(haname)
#File.delete(hbname)
File.delete(hcname)
#  
