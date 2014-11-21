#---INTRODUCTION---
#<description> 
# A script that...
#	xx1. shows instant avg fleet speed 
#	xx2. in the console
#	xx3. for multiple agencies
# 	xx4. and is refreshed every (d) seconds
#	xx5. tracks moving avg fleet speed
# 	xx6. writes several log and data files
#	xx7. populates files with data
#	xx8. longitude and latitude
# 	xx9. log file
#	xx10. log as many attribute fields as possible
# 	xx11. fix kmh/mph speed issue
#	xx12. add rolling average speed bar graph to console
#	xx13. add wolfline & other agencies
#	xx14. write html chart file. 
#	15. fix force close error - probably something to with null variable handling
#	xx16. dashboard away from console and into google charts. 
#	xx17.	google bar chart for bus instant and average speed
# 	xx18. historgram for individual bus speed

#<agency_id values for reference>
# C-Tran/Cary 		= 367
# DATA/Durham 		= 24
# CHT/Chapel Hill 	= 8
# DukeU 			= 176
# Wolfline/NCSU 	= 16
# TTA 				= 12
# Raleigh/CAT 		= 20
# Chicago/CTA		= 104

#<require statements>
require 'unirest'
require 'json'
#<initital variable setup>

hfull = "histogram.html"
haname = "histogramcacheA #{Time.now.strftime('%Y%m%d')}.txt"			#header
hbname = "histogramcacheB #{Time.now.strftime('%Y%m%d')}.txt"			#data
File.open(hbname, "w+") do |zz2|
zz2.puts ""
end
hcname = "histogramcacheC #{Time.now.strftime('%Y%m%d')}.txt"			#footer

d = 0
data_hash = 0
e = "CAT mph = "
f = "TTA mph = "
fname = "AgencySpeed_bus #{Time.now.strftime('%Y%m%d')}.txt"		#Creates a new .txt file in directory of .rb
gname = "AgencySpeed_avg #{Time.now.strftime('%Y%m%d')}.txt"		#Creates a new .txt file in directory of .rb
hname = "AgencySpeed_log #{Time.now.strftime('%Y%m%d')}.txt"		#Creates a new .txt file in directory of .rb
payload = 0
payload2 = 0
response = 0
varAvg = 0
varAvgt = 0
varAvgw	= 0
varCcum = 0
varCcumCt = 0
varCcumSpd = 0
varCount = 0
varCountt = 0
varCountw = 0
varHd = 0
varHdt = 0
varHdw = 0
varI = 0
varLat = 0
varLatt = 0
varLatw = 0
varLng = 0															#variable that represents starting integer for loop count
varLngt = 0
varLngw = 0
varNum = 0
varRt = 0
varRtt = 0
varRtw = 0
varSeg = 0
varSegt = 0
varSegw = 0
varSpd = 0
varSpdt = 0
varSpdw = 0
varSum = 0
varSumt = 0
varSumw = 0
varTcum = 0
varTcumCt = 0
varTcumSpd = 0
varTime = 0
varVID = 0
varVIDt = 0
varVIDw = 0
varWcum = 0
varWcumCt = 0
varWcumSpd = 0
w = "WLF mph = "

#variables related to line chart
vc1 = 0
vc2 = 0
vc3 = 0
vc4 = 0
vc5 = 0
vc6 = 0
vc7 = 0
vc8 = 0
vc9 = 0
vc10 = 0
vc11 = 0
vc12 = 0
vc13 = 0
vc14 = 0
vc15 = 0
vc16 = 0
vc17 = 0
vc18 = 0
vc19 = 0
vc20 = 0
vt1 = 0
vt2 = 0
vt3 = 0
vt4 = 0
vt5 = 0
vt6 = 0
vt7 = 0
vt8 = 0
vt9 = 0
vt10 = 0
vt11 = 0
vt12 = 0
vt13 = 0
vt14 = 0
vt15 = 0
vt16 = 0
vt17 = 0
vt18 = 0
vt19 = 0
vt20 = 0
vw1 = 0
vw2 = 0
vw3 = 0
vw4 = 0
vw5 = 0
vw6 = 0
vw7 = 0
vw8 = 0
vw9 = 0
vw10 = 0
vw11 = 0
vw12 = 0
vw13 = 0
vw14 = 0
vw15 = 0
vw16 = 0
vw17 = 0
vw18 = 0
vw19 = 0
vw20 = 0
ti20 = 0
ti19 = 0
ti18 = 0
ti17 = 0
ti16 = 0
ti15 = 0
ti14 = 0
ti13 = 0
ti12 = 0
ti11 = 0
ti10 = 0
ti9 = 0
ti8 = 0
ti7 = 0
ti6 = 0
ti5 = 0
ti4 = 0
ti3 = 0
ti2 = 0
ti1 = 0


#<write logfile headers>
File.open(fname, "a+") do |f1|
	f1.puts "year,month,day,time,agency,bus_id,mph,lon,lat,route,heading,segment_id"
end
File.open(gname, "a+") do |g7|
	g7.puts "time,agency,count_buses,mph"
end
File.open(hname, "a+") do |h2|
	h2.puts "###CONSOLE LOG FILE###"
	h2.puts ""
	h2.puts ""
	h2.puts "How long to sleep (in seconds) between each loop? (typically ~5)"
	h2.puts "#{d} seconds delay"
	h2.puts "How many loops to perform? (typically ~10)"
	h2.puts "#{varNum} loops"
end

#---LAUNCH CONSOLE---
#<gets prompt>
puts 'How long to sleep (in seconds) between each loop? (typically ~5)'
d = gets.to_i 															
puts "\e[H\e[2J"
puts "#{d} seconds delay"
sleep(2)
puts "\e[H\e[2J"
puts 'How many loops to perform? (typically ~10)'
varNum = gets.to_i         					#tracks number of repeat iterations
puts "\e[H\e[2J"
puts "#{varNum} loops"
sleep(2)

#---ITERATIVE LOOP---
begin
#HA 
#<variables>
varI +=1;
File.open(haname, "w+") do |ha1|
	ha1.puts "<html>"
	ha1.puts "<head>"
	if varI < varNum
	ha1.puts "#{"<META HTTP-EQUIV="}#{'"'}#{"refresh"}#{'"'}#{" CONTENT="}#{'"'}#{90}#{'"'}#{">"}#{'"'}"#refresh code
	end
	ha1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
#historgram
	ha1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"		#<script type="text/javascript">
	ha1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"	# google.load("visualization", "1", {packages:["corechart"]});
	ha1.puts "#{"google.setOnLoadCallback(drawChart3);"}"					# google.setOnLoadCallback(drawChart3);
	ha1.puts "#{"function drawChart3() {"}"									# function drawChart3() {
	ha1.puts "#{"var data3 = google.visualization.arrayToDataTable(["}"		# var data3 = google.visualization.arrayToDataTable([	
	ha1.puts "#{"['CAT', 'TTA', 'WLF'],"}"
end
#/HA

#<variables>
varTime = "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')}"
varTi1 = "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}"
varCountw = 0
varCountt = 0
varCount = 0 								#Counts the number of buses that respond during 
											#	each iteration
varSumw = 0
varSumt = 0											
varSum = 0 									#The sum of the speed values for each responding 
											#	bus during each iteration
varAvgw = 0
varAvgt = 0	
varAvg = 0									#A value derived from varSum divided by varCount 
											#	that equals the average speed for all responding 
											#	buses during each iteration

varSpd = 0
varVID = 0
varLng = 0
varLat = 0
varRt = 0
varHd = 0
varSeg = 0
varSpdt = 0
varVIDt = 0
varLngt = 0
varLatt = 0
varRtt = 0
varHdt = 0
varSegt = 0
varSpdw = 0
varVIDw = 0
varLngw = 0
varLatw = 0
varRtw = 0
varHdw = 0
varSegw = 0

#<call the transloc api>
#response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=12%2C16%2C20&callback=call&geo_area=35.777531%2C-78.637277%7C500.0",
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=12%2C16%2C20&callback=call",
  headers:{
    "X-Mashape-Key" => "<key>"
  }
#<parse the call>
payload2 = response.body					#sets the call response body as a variable
payload = payload2[/{.+}/]					#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)				#parses the response body and stores as a variable

#<console writing>
puts "\e[H\e[2J"							#clears console
puts "Loop delay: #{d} seconds" 			#loop delay in seconds
puts "Iterations: #{varI} of #{varNum+1}"	#x of y count

#<log file writing>
File.open(hname, "a+") do |h1|
	h1.puts ""
	h1.puts ""
	h1.puts "Iteration: #{varI} of #{varNum+1}"		#x of y count
	h1.puts "Current Time: #{varTime}"				#current time
end

#<data loop><cat>
data_hash["data"]["20"].each do |ary|		#for each object in the array,
varSpd = 0									#*
varSpd = ary["speed"] * 0.621371			#set var for "speed" (mph) value in array - api default units is kmh
varVID = ary["vehicle_id"]					#set var for "vehicle_id" value in array,
varLng = ary["location"]["lng"]				#set var for longitude value in array,
varLat = ary["location"]["lat"]				#set var for latitude value in array,
varRt = ary["route_id"]						#set var for route_id value in array
varHd = ary["heading"]						#set var for heading value in array
varSeg = ary["segment_id"]					#set var for segment_id value in array
varCount = varCount + 1						#increase repeat iterations by 1,
varSum = varSum + varSpd					#separately, set var for sum of all "speed" values in array,
varCcumSpd = varCcumSpd + varSpd			#cumulative speed tracking
varCcumCt = varCcumCt + 1					#cumulative count tracking

#histogram


if varSpd > 0
File.open(hbname, "a+") do |hb1|
	#hb1.puts "#{"['"}#{varVID}#{"', "}#{varSpd.round(1)}#{"],"}"
	hb1.puts "#{"["}#{varSpd.round(1)}#{",null,null],"}"
end
end


#write it to a file
File.open(fname, "a+") do |f4|
	f4.puts "#{Time.now.strftime('%Y')},#{Time.now.strftime('%m')},#{Time.now.strftime('%d')},#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},CAT,#{varVID},#{varSpd.round(1)},#{varLng},#{varLat},#{varRt},#{varHd},#{varSeg}"
end
#varSpd = 0
varVID = 0
varLng = 0
varLat = 0
varRt = 0
varHd = 0
varSeg = 0
end											#...end array loop

if varCount > 0 
varAvg = varSum / varCount					#calculate CAT instant average bus speed
end

if varCcumCt > 0
varCcum = varCcumSpd / varCcumCt			#calculate CAT cumulative average bus speed
end

File.open(gname, "a+") do |g2|
	g2.puts "#{varTime},CAT,#{varCount},#{varAvg.round(1)}"
end
File.open(hname, "a+") do |h1|
h1.puts "#{e} #{varAvg.round(1)} (#{varCcum.round(1)} cumulative)"
end
vc20 = vc19
vc19 = vc18
vc18 = vc17
vc17 = vc16
vc16 = vc15
vc15 = vc14
vc14 = vc13
vc13 = vc12
vc12 = vc11
vc11 = vc10
vc10 = vc9
vc9 = vc8
vc8 = vc7
vc7 = vc6
vc6 = vc5
vc5 = vc4
vc4 = vc3
vc3 = vc2
vc2 = vc1
vc1 = varAvg
#</cat>



#<data loop><tta>
Array(data_hash["data"]["12"]).each do |aryt|		#for each object in the array,
varSpdt = 0									#*
varSpdt = aryt["speed"] * 0.621371			#set var for "speed" value in array, convert to mph
varVIDt = aryt["vehicle_id"]				#set var for "vehicle_id" value in array,
varLngt = aryt["location"]["lng"]			#set var for longitude value in array,
varLatt = aryt["location"]["lat"]			#set var for latitude value in array,
varRtt = aryt["route_id"]					#set var for route_id value in array
varHdt = aryt["heading"]					#set var for heading value in array
varSegt = aryt["segment_id"]				#set var for segment_id value in array
varCountt = varCountt + 1					#increase repeat iterations by 1,
varSumt = varSumt + varSpdt					#separately, set var for sum of all "speed" values in array,
varTcumSpd = varTcumSpd + varSpdt			#cumulative speed tracking
varTcumCt = varTcumCt + 1					#cumulative count tracking



if varSpdt > 0
File.open(hbname, "a+") do |hb1|
	#hb1.puts "#{"['"}#{varVIDt}#{"', "}#{varSpdt.round(1)}#{"],"}"
	hb1.puts "#{"[null,"}#{varSpdt.round(1)}#{",null],"}"
end
end


File.open(fname, "a+") do |f5|
	f5.puts "#{Time.now.strftime('%Y')},#{Time.now.strftime('%m')},#{Time.now.strftime('%d')},#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},TTA,#{varVIDt},#{varSpdt.round(1)},#{varLngt},#{varLatt},#{varRtt},#{varHdt},#{varSegt}"
end	

varVIDt = 0
varLngt = 0
varLatt = 0
varRtt = 0
varHdt = 0
varSegt = 0
end											#...end array loop

if varCountt > 0 
varAvgt = varSumt / varCountt				#calculate TTA instant average bus speed
end 

if varTcumCt > 0
varTcum = varTcumSpd / varTcumCt			#calculate TTA cumulative avgerage bus speed
end

File.open(gname, "a+") do |g3|
	g3.puts "#{varTime},TTA,#{varCountt},#{varAvgt.round(1)}"
end
File.open(hname, "a+") do |h1|
h1.puts "#{f} #{varAvgt.round(1)} (#{varTcum.round(1)} cumulative)"
end
vt20 = vt19
vt19 = vt18
vt18 = vt17
vt17 = vt16
vt16 = vt15
vt15 = vt14
vt14 = vt13
vt13 = vt12
vt12 = vt11
vt11 = vt10
vt10 = vt9
vt9 = vt8
vt8 = vt7
vt7 = vt6
vt6 = vt5
vt5 = vt4
vt4 = vt3
vt3 = vt2
vt2 = vt1
vt1 = varAvgt
#</tta>


#<data loop><wlf>
Array(data_hash["data"]["16"]).each do |aryw|		#for each object in the array,
varSpdw = 0
varSpdw = aryw["speed"] * 0.621371			#set var for "speed" value in array, convert to mph
varVIDw = aryw["vehicle_id"]				#set var for "vehicle_id" value in array,
varLngw = aryw["location"]["lng"]			#set var for longitude value in array,
varLatw = aryw["location"]["lat"]			#set var for latitude value in array,
varRtw = aryw["route_id"]					#set var for route_id value in array
varHdw = aryw["heading"]					#set var for heading value in array
varSegw = aryw["segment_id"]				#set var for segment_id value in array
varCountw = varCountw + 1					#increase repeat iterations by 1,
varSumw = varSumw + varSpdw					#separately, set var for sum of all "speed" values in array,
varWcumSpd = varWcumSpd + varSpdw			#cumulative speed tracking
varWcumCt = varWcumCt + 1					#cumulative count tracking


if varSpdw > 0
File.open(hbname, "a+") do |hb1|
	#hb1.puts "#{"['"}#{varVIDw}#{"', "}#{varSpdw.round(1)}#{"],"}"
	hb1.puts "#{"[null,null,"}#{varSpdw.round(1)}#{"],"}"
end
end


File.open(fname, "a+") do |f6|
	f6.puts "#{Time.now.strftime('%Y')},#{Time.now.strftime('%m')},#{Time.now.strftime('%d')},#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},WLF,#{varVIDw},#{varSpdw.round(1)},#{varLngw},#{varLatw},#{varRtw},#{varHdw},#{varSegw}"
end	

varVIDw = 0
varLngw = 0
varLatw = 0
varRtw = 0
varHdw = 0
varSegw = 0
end											#...end array loop

if varCountw > 0
varAvgw	= varSumw / varCountw				#calculate WLF instant average bus speed
end

if varWcumCt > 0
varWcum = varWcumSpd / varWcumCt			#calculate WLF cumulative average bus speed
end

File.open(gname, "a+") do |g4|
	g4.puts "#{varTime},WLF,#{varCountw},#{varAvgw.round(1)}"
end
File.open(hname, "a+") do |h1|
h1.puts "#{w} #{varAvgw.round(1)} (#{varWcum.round(1)} cumulative)"
end
vw20 = vw19
vw19 = vw18
vw18 = vw17
vw17 = vw16
vw16 = vw15
vw15 = vw14
vw14 = vw13
vw13 = vw12
vw12 = vw11
vw11 = vw10
vw10 = vw9
vw9 = vw8
vw8 = vw7
vw7 = vw6
vw6 = vw5
vw5 = vw4
vw4 = vw3
vw3 = vw2
vw2 = vw1
vw1 = varAvgw
#</wlf>







#<google line chart writing>
#variables
ti20 = ti19
ti19 = ti18
ti18 = ti17
ti17 = ti16
ti16 = ti15
ti15 = ti14
ti14 = ti13
ti13 = ti12
ti12 = ti11
ti11 = ti10
ti10 = ti9
ti9 = ti8
ti8 = ti7
ti7 = ti6
ti6 = ti5
ti5 = ti4
ti4 = ti3
ti3 = ti2
ti2 = ti1
ti1 = varTi1

#HC Header
File.open(hcname, "w+") do |hc1|
	hc1.puts "#{"]);"}"
	hc1.puts "#{"var options3 = {"}"								# var options3 = {	
	hc1.puts "#{"title: 'Speed of Individual Buses',"}"			# title: 'foo',
	hc1.puts "#{"legend: { position: 'right' },"}"
	hc1.puts "#{"histogram: { bucketSize: 5 },"}"
	hc1.puts "#{"isStacked: ['True']"}"
	hc1.puts "#{"};"}"
	hc1.puts "#{"var chart3 = new google.visualization.Histogram(document.getElementById('chart_div3'));"}"												# var chart2 = new google.visualization.BarChart(document.getElementById('chart_div2'));	
	hc1.puts "#{"chart3.draw(data3, options3);"}"
	hc1.puts "#{"}"}"
	hc1.puts "#{"</script>"}"
	hc1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
	hc1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"
	hc1.puts "#{"google.setOnLoadCallback(drawChart);"}"
	hc1.puts "#{"var c1 = "}#{vc1}"
    hc1.puts "#{"var c2 = "}#{vc2}"
    hc1.puts "#{"var c3 = "}#{vc3}"
    hc1.puts "#{"var c4 = "}#{vc4}"
    hc1.puts "#{"var c5 = "}#{vc5}"
    hc1.puts "#{"var c6 = "}#{vc6}"
    hc1.puts "#{"var c7 = "}#{vc7}"
    hc1.puts "#{"var c8 = "}#{vc8}"
    hc1.puts "#{"var c9 = "}#{vc9}"
    hc1.puts "#{"var c10 = "}#{vc10}"
    hc1.puts "#{"var c11 = "}#{vc11}"
    hc1.puts "#{"var c12 = "}#{vc12}"
    hc1.puts "#{"var c13 = "}#{vc13}"
    hc1.puts "#{"var c14 = "}#{vc14}"
    hc1.puts "#{"var c15 = "}#{vc15}"
    hc1.puts "#{"var c16 = "}#{vc16}"
    hc1.puts "#{"var c17 = "}#{vc17}"
    hc1.puts "#{"var c18 = "}#{vc18}"
    hc1.puts "#{"var c19 = "}#{vc19}"
    hc1.puts "#{"var c20 = "}#{vc20}"
	hc1.puts "#{"var t1 = "}#{vt1}"
    hc1.puts "#{"var t2 = "}#{vt2}"
    hc1.puts "#{"var t3 = "}#{vt3}"
    hc1.puts "#{"var t4 = "}#{vt4}"
	hc1.puts "#{"var t5 = "}#{vt5}"
    hc1.puts "#{"var t6 = "}#{vt6}"
    hc1.puts "#{"var t7 = "}#{vt7}"
    hc1.puts "#{"var t8 = "}#{vt8}"
    hc1.puts "#{"var t9 = "}#{vt9}"
    hc1.puts "#{"var t10 = "}#{vt10}"
    hc1.puts "#{"var t11 = "}#{vt11}"
    hc1.puts "#{"var t12 = "}#{vt12}"
    hc1.puts "#{"var t13 = "}#{vt13}"
    hc1.puts "#{"var t14 = "}#{vt14}"
	hc1.puts "#{"var t15 = "}#{vt15}"
    hc1.puts "#{"var t16 = "}#{vt16}"
    hc1.puts "#{"var t17 = "}#{vt17}"
    hc1.puts "#{"var t18 = "}#{vt18}"
    hc1.puts "#{"var t19 = "}#{vt19}"
    hc1.puts "#{"var t20 = "}#{vt20}"
	hc1.puts "#{"var w1 = "}#{vw1}"
    hc1.puts "#{"var w2 = "}#{vw2}"
    hc1.puts "#{"var w3 = "}#{vw3}"
    hc1.puts "#{"var w4 = "}#{vw4}"
    hc1.puts "#{"var w5 = "}#{vw5}"
    hc1.puts "#{"var w6 = "}#{vw6}"
    hc1.puts "#{"var w7 = "}#{vw7}"
    hc1.puts "#{"var w8 = "}#{vw8}"
    hc1.puts "#{"var w9 = "}#{vw9}"
    hc1.puts "#{"var w10 = "}#{vw10}"
	hc1.puts "#{"var w11 = "}#{vw11}"
    hc1.puts "#{"var w12 = "}#{vw12}"
    hc1.puts "#{"var w13 = "}#{vw13}"
    hc1.puts "#{"var w14 = "}#{vw14}"
    hc1.puts "#{"var w15 = "}#{vw15}"
    hc1.puts "#{"var w16 = "}#{vw16}"
    hc1.puts "#{"var w17 = "}#{vw17}"
    hc1.puts "#{"var w18 = "}#{vw18}"
    hc1.puts "#{"var w19 = "}#{vw19}"
    hc1.puts "#{"var w20 = "}#{vw20}"
	hc1.puts "#{"var ti1 = "}#{"'"}#{ti1}#{"'"}"
    hc1.puts "#{"var ti2 = "}#{"'"}#{ti2}#{"'"}"
    hc1.puts "#{"var ti3 = "}#{"'"}#{ti3}#{"'"}"
    hc1.puts "#{"var ti4 = "}#{"'"}#{ti4}#{"'"}"
    hc1.puts "#{"var ti5 = "}#{"'"}#{ti5}#{"'"}"
    hc1.puts "#{"var ti6 = "}#{"'"}#{ti6}#{"'"}"
    hc1.puts "#{"var ti7 = "}#{"'"}#{ti7}#{"'"}"
    hc1.puts "#{"var ti8 = "}#{"'"}#{ti8}#{"'"}"
    hc1.puts "#{"var ti9 = "}#{"'"}#{ti9}#{"'"}"
    hc1.puts "#{"var ti10 = "}#{"'"}#{ti10}#{"'"}"
    hc1.puts "#{"var ti11 = "}#{"'"}#{ti11}#{"'"}"
    hc1.puts "#{"var ti12 = "}#{"'"}#{ti12}#{"'"}"
    hc1.puts "#{"var ti13 = "}#{"'"}#{ti13}#{"'"}"
    hc1.puts "#{"var ti14 = "}#{"'"}#{ti14}#{"'"}"
    hc1.puts "#{"var ti15 = "}#{"'"}#{ti15}#{"'"}"
    hc1.puts "#{"var ti16 = "}#{"'"}#{ti16}#{"'"}"
    hc1.puts "#{"var ti17 = "}#{"'"}#{ti17}#{"'"}"
    hc1.puts "#{"var ti18 = "}#{"'"}#{ti18}#{"'"}"
    hc1.puts "#{"var ti19 = "}#{"'"}#{ti19}#{"'"}"
    hc1.puts "#{"var ti20 = "}#{"'"}#{ti20}#{"'"}"

	
#bar chart vars here
    hc1.puts "#{"var vc1 = "}#{vc1}"
    hc1.puts "#{"var vt1 = "}#{vt1}"
    hc1.puts "#{"var vw1 = "}#{vw1}"
    hc1.puts "#{"var varCcum = "}#{varCcum}"
    hc1.puts "#{"var varTcum = "}#{varTcum}"
    hc1.puts "#{"var varWcum = "}#{varWcum}"
#/bar vars
	hc1.puts "#{"function drawChart() {"}"
	hc1.puts "#{"var data = google.visualization.arrayToDataTable(["}"
    hc1.puts "#{"['P',	'CAT',	'TTA',	'WLF'],"}"
    hc1.puts "#{"[ti1,	c1,		t1,		w1],"}"
    hc1.puts "#{"[ti2,	c2,		t2,		w2],"}"
	hc1.puts "#{"[ti3,	c3,		t3,		w3],"}"
	hc1.puts "#{"[ti4,	c4,		t4,		w4],"}"
	hc1.puts "#{"[ti5,	c5,		t5,		w5],"}"
	hc1.puts "#{"[ti6,	c6,		t6,		w6],"}"
	hc1.puts "#{"[ti7,	c7,		t7,		w7],"}"
	hc1.puts "#{"[ti8,	c8,		t8,		w8],"}"
	hc1.puts "#{"[ti9,	c9,		t9,		w9],"}"
	hc1.puts "#{"[ti10,	c10,	t10,	w10],"}"	
	hc1.puts "#{"[ti11,	c11,	t11,	w11],"}"
    hc1.puts "#{"[ti12,	c12,	t12,	w12],"}"
	hc1.puts "#{"[ti13,	c13,	t13,	w13],"}"
	hc1.puts "#{"[ti14,	c14,	t14,	w14],"}"
	hc1.puts "#{"[ti15,	c15,	t15,	w15],"}"
	hc1.puts "#{"[ti16,	c16,	t16,	w16],"}"
	hc1.puts "#{"[ti17,	c17,	t17,	w17],"}"
	hc1.puts "#{"[ti18,	c18,	t18,	w18],"}"
	hc1.puts "#{"[ti19,	c19,	t19,	w19],"}"
	hc1.puts "#{"[ti20,	c20,	t20,	w20]"}"	
	hc1.puts "#{"]);"}"
	hc1.puts "#{"var options = {"}"
	hc1.puts "#{"title: 'Bus Fleet Speed',"}"
	hc1.puts "#{"curveType: 'function',"}"
	hc1.puts "#{"hAxis: {showTextEvery: 3, direction: -1},"}"	#option
	hc1.puts "#{"vAxis: {minValue: 0},"}"	#option
	hc1.puts "#{"};"}"
	hc1.puts "#{"var chart = new google.visualization.LineChart(document.getElementById('chart_div'));"}"
	hc1.puts "#{"chart.draw(data, options);"}"
	hc1.puts "#{"}"}"
	hc1.puts "#{"</script>"}"
#put bar chart here
	hc1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"		#<script type="text/javascript">
	hc1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"	# google.load("visualization", "1", {packages:["corechart"]});
	hc1.puts "#{"google.setOnLoadCallback(drawChart2);"}"					# google.setOnLoadCallback(drawChart2);
	hc1.puts "#{"function drawChart2() {"}"									# function drawChart2() {
	hc1.puts "#{"var data2 = google.visualization.arrayToDataTable(["}"		# var data2 = google.visualization.arrayToDataTable([
    hc1.puts "#{"['Agency',	'Instant',{ role: 'style'},	'Average',{ role: 'style'},],"}"						# ['Agency', 'Instant MPH', 'Average MPH'],
    hc1.puts "#{"['CAT',vc1,'blue',varCcum,'#CCE5FF'],"}"					# ['CAT',  35,      14],
    hc1.puts "#{"['TTA',vt1,'red',varTcum,'#FFCCCC'],"}"					# ['TTA',  55,      19],
    hc1.puts "#{"['WLF',vw1,'orange',varWcum,'#FFE5CC']"}"						# ['WLF',  10,       12]
	hc1.puts "#{"]);"}"														# ]);
	hc1.puts "#{"var options2 = {"}"											# var options2 = {
	hc1.puts "#{"title: 'Bus Fleet Speed - instant vs average MPH',"}"			# title: 'Bus Fleet Speed - instant vs average',
	hc1.puts "#{"hAxis: {minValue: 0},"}"	
	hc1.puts "#{"legend: { position: "}#{'"'}#{"none"}#{'"'}#{" },"}"
	#legend: { position: "none" },
	hc1.puts "#{"};"}"														# };
	hc1.puts "#{"var chart2 = new google.visualization.BarChart(document.getElementById('chart_div2'));"}"												# var chart2 = new google.visualization.BarChart(document.getElementById('chart_div2'));
	hc1.puts "#{"chart2.draw(data2, options2);"}"							# chart2.draw(data2, options2);
	hc1.puts "#{"}"}"														# }
	hc1.puts "#{"</script>"}"												# </script>
#/bar chart
	hc1.puts "#{"</head>"}"
	hc1.puts "#{"<body>"}"
	hc1.puts "#{"<div id="}#{'"'}#{"chart_div"}#{'"'}#{" style="}#{'"'}#{"width: 600px; height: 200px;"}#{'"'}#{"></div>"}"
	hc1.puts "#{"<div id="}#{'"'}#{"chart_div2"}#{'"'}#{" style="}#{'"'}#{"width: 600px; height: 250px;"}#{'"'}#{"></div>"}"
	hc1.puts "#{"<div id="}#{'"'}#{"chart_div3"}#{'"'}#{" style="}#{'"'}#{"width: 600px; height: 250px;"}#{'"'}#{"></div>"}"
	hc1.puts "#{"</body>"}"
	hc1.puts "#{"</html>"}"
end
#/HC Header

#cache work
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
#/cache work

sleep(d)
end until varI > varNum

File.delete(haname)
File.delete(hbname)
File.delete(hcname)

#---CLEANUP---
puts "done"
sleep(2)
exit
