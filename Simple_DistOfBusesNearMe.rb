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
dNearestA = 9999							#record nearest bus - SET HIGH up front and reduce
dNearestB = 9999							#record nearest bus - SET HIGH up front and reduce
dCacheA = 0
dCacheB = 0
dA = 0
dB = 0
varVctA = 0
varVctB = 0
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
	ha1.puts "#{"['ID', 'Time', 'Miles', 'Color', 'Buses w/in 1/4 mile'],"}"										# "['#{varXTime}', '#{d}'],"
end
puts "\e[H\e[2J"
def power(num, pow)
num ** pow
end
#
#--MY-LOCATION--
=begin
varmyLng = -78.637277	#moore square
varmyLat = 35.777531	#moore square
#
varmyLng = -78.645741	#5 points
varmyLat = 35.804011	#5 points
#
varmyLng = -78.64883	#boylan @ johnson
varmyLat = 35.787388	#boylan @ johnson
#
varmyLng = -78.677987	#crabtree valley mall
varmyLat = 35.838014	#crabtree valley mall
varName = "Crabtree Valley Mall"
#
varmyLng = -78.640713	#raleigh convention center
varmyLat = 35.774087	#raleigh convention center
varName = "Raleigh Convention Center"
=end
#
varmyLngA = -78.640713	#raleigh convention center
varmyLatA = 35.774087	#raleigh convention center
varNameA = "Raleigh Convention Center"
#
varmyLngB = -78.677987	#crabtree valley mall
varmyLatB = 35.838014	#crabtree valley mall
varNameB = "Crabtree Valley Mall"
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

varGenTime = data_hash["generated_on"]
varDate = DateTime.parse(varGenTime)
varDate = varDate.to_time.iso8601
varDate = DateTime.parse(varDate)
varHour = varDate.hour.to_f
varMin = varDate.minute.to_f
varXTime = varHour + (varMin / 60)
#--BLOCK-A--
Array(data_hash["data"]["20"]).each do |blockA|
varLatA = 0
varLngA = 0
varLatA = blockA["location"]["lat"]
varLngA = blockA["location"]["lng"]
#
#--calc-distance--
dtorA = Math::PI/180
r = 3959
rlat1A = varmyLatA * dtorA 
rlong1A = varmyLngA * dtorA 
rlat2A = varLatA * dtorA
rlong2A = varLngA * dtorA
dlonA = rlong1A - rlong2A
dlatA = rlat1A - rlat2A
aA = power(Math::sin(dlatA/2), 2) + Math::cos(rlat1A) * Math::cos(rlat2A) * power(Math::sin(dlonA/2), 2)
cA = 2 * Math::atan2(Math::sqrt(aA), Math::sqrt(1-aA))
dA = r * cA
#
#--STORE-NEAREST-BUS--
dCacheA = dA						#temp cache distance for "nearest" calcs
if dCacheA < dNearestA
dNearestA = dCacheA					#record nearest bus
end
#
if dA < 0.250
varVctA += 1
end
end
File.open(hbname, "a+") do |hb1|
	hb1.puts "#{"['',"}#{varXTime}, #{dNearestA}, '#{varNameA}', #{varVctA}#{"],"}"				#[time,distance] ---> # "[#{varXTime}, #{dNearest}],"
end
#
#--BLOCK-B--
Array(data_hash["data"]["20"]).each do |blockB|
varLatB = 0
varLngB = 0
varLatB = blockB["location"]["lat"]
varLngB = blockB["location"]["lng"]
#
#--calc-distance--
dtorB = Math::PI/180
r = 3959
rlat1B = varmyLatB * dtorB 
rlong1B = varmyLngB * dtorB 
rlat2B = varLatB * dtorB
rlong2B = varLngB * dtorB
dlonB = rlong1B - rlong2B
dlatB = rlat1B - rlat2B
aB = power(Math::sin(dlatB/2), 2) + Math::cos(rlat1B) * Math::cos(rlat2B) * power(Math::sin(dlonB/2), 2)
cB = 2 * Math::atan2(Math::sqrt(aB), Math::sqrt(1-aB))
dB = r * cB
#
#--STORE-NEAREST-BUS--
dCacheB = dB						#temp cache distance for "nearest" calcs
if dCacheB < dNearestB
dNearestB = dCacheB					#record nearest bus
end
#
if dB < 0.250
varVctB += 1
end
end
File.open(hbname, "a+") do |hb1|
	hb1.puts "#{"['',"}#{varXTime}, #{dNearestB}, '#{varNameB}', #{varVctB}#{"],"}"				#[time,distance] ---> # "[#{varXTime}, #{dNearest}],"
end
#
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
	hc1.puts "<font size=#{'"'}30#{'"'} color=#{'"'}red#{'"'}><b>#{varVctA}</b></font><br>"
	hc1.puts "buses within 1/4 mile of #{varNameA}"
	hc1.puts "<br>"
	hc1.puts "<font size=#{'"'}30#{'"'} color=#{'"'}red#{'"'}><b>#{varVctB}</b></font><br>"
	hc1.puts "buses within 1/4 mile of #{varNameB}"
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
