# A ruby script that post-processes [logged] real-time next bus arrival 
# data to create a scatter chart showing average wait in minutes for a 
# particular bus stop as a scatter chart for a queried date.  X = time 
# of day; Y = minutes to next bus arrival. You are able to query 
# specific stops and routes in the #INPUTS section of the code below

# Place this script in the same directory as your next bus arrival 
# data named CATAvgStopWait*.txt.  

# Under INPUTS below enter the start date that you want to begin the
# query from (will run until the last day of the last year you have
# data for).  Also, for vSS enter your desired sample rate as an 
# integer(i) 1/i.  The script has a lot of data to process so sampling
# a fraction (sometimes as little as 1%) results in a decent output
# completed in a fraction of the time. 

# The output AvgStopWait_Scatter_Infographic_CAT.html will be created 
# in the same directory this script is run from.  

require 'descriptive_statistics'	
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'CSV'
require 'time'
require 'date'

#INPUTS
#---begin-hour----------/
#vHrMin = 7			# 7 = 0700 = 7am start	#TB700
#---end-hour------------/
#vHrMax = 17			# 9 = 1700 = 4:49pm end #TB700
#---stop----------------/
varStp1 = "4102202"	#4102202 = Peace St. at Seaboard Station, 4100198 == moore square station
#---route---------------/
varRt1 = "r-line"		
#---year----------------/
varYi1 = 2015 		#year increment start
#---month---------------/
varMi1 = 2 		#month increment start (0 = jan, 1 = feb, etc)
#---day-----------------/
varDi1 = 3			#day increment start
#---sample-size---------/
vSS1 = 1			#percent sample rate 1/x
#/INPUTS

#vars/defs
cacheRand1 = "cacheRandwt1.txt"
if File.exists?(cacheRand1)	
File.delete(cacheRand1)
end
cacheA1 = "cacheAwt1.txt"
if File.exists?(cacheA1)	
File.delete(cacheA1)
end
cacheB1 = "cacheBwt1.txt"
if File.exists?(cacheB1)	
File.delete(cacheB1)
end
cacheC1 = "cacheCwt1.txt"
if File.exists?(cacheC1)	
File.delete(cacheC1)
end
calFull = "AvgStopWait_Scatter_Infographic_CAT.html"		#chart output file
#arrCal = [0]		#TB700
arrCount = [0]						#counting how many lines in each file to filter out incomplete days
varI = 1
varDate = 0
varYer = 0
varMon = 0
varDay = 0
varHr = 0
varMin = 0
#varRt1 = varRt1.to_s	#TB700
varMia = varMi1 + 1		#logic that converts month integer back to true calendar (i.e. 12 = dec)
#/vars/defs

#HEADERS
puts "\e[H\e[2J"
puts "AvgStopWait_Cal_Infographic_CAT.rb"
varSt = Time.now 
varLast = varSt
puts "Started: #{varSt}" 
puts ""
#Count total lines in all .txt files
varLNC = 0		#count of line numbers in all .txt files
Dir.glob('CATAvgStopWait *.txt') do |cl1|
File.foreach(cl1).with_index { |line, line_num|
varLNC += 1;
}
end
#/Count total lines in all .txt files
puts "**************"
puts "Start Date: #{varYi1}-#{varMi1}-#{varDi1}"
puts "Population Size: #{varLNC}"
puts "Desired Sample: #{100/vSS1.to_f}% of population"
puts "**************"
puts ""
#/HEADERS

#Create temp sample cache .txt file								#Variable will tell how many lines in a record
Dir.glob('CATAvgStopWait *.txt') do |foo|		#For each file named 'CATAvg...txt" read as foo
randfile = File.open(cacheRand1, "a+")			#Open the cache file

varFooYr = 0					#TB1
varFooMo = 0					#TB1
varFooDa = 0					#TB1
varFooC = 0						#TB1
varFooD = 0						#TB1

#filter out unnecessary files b/c we're not using data from that time period. 
varFooYr = foo[15...19].to_i	#TB1
varFooMo = foo[19...21].to_i	#TB1
varFooDa = foo[21...23].to_i	#TB1


varFooC = Date.new(varFooYr,varFooMo,varFooDa).yday	#filename day of year	#TB1
varFooC = varFooYr.to_f + (varFooC.to_f / 365)		#TB1
varFooD = Date.new(varYi1,varMia,varDi1).yday		#day of year of query	#TB1
varFooD = varYi1.to_f + (varFooD.to_f / 365)		#TB1

if varFooC >= varFooD				#TB1

list = CSV.foreach(foo) do |row1|				#For each record in foo
varRN = row1[0]									#read an attribute of the record
if varRN == "gendate"							#if the line of the file is the header
else											#skip the line
varRNy = row1[0][0...4].to_i					#Manual parse to get the year of the record 
varRNm = row1[0][5...7].to_i					#Manual parse to get the month of the record
varRNd = row1[0][8...10].to_i					#Manual parse to get the day of the record
varRNh = row1[0][11...13].to_i					#Manual parse to get the hour of the record

if varRNy > 0									#Error handling - if record is null just skip
varRNb = Date.new(varRNy,varRNm,varRNd).yday	#Get the day of year for the record
varRNb = varRNy.to_f + (varRNb.to_f / 365)		#Convert it to a floating point integer
varRNc = Date.new(varYi1,varMia,varDi1).yday	#Get the day of year for the query start date
varRNc = varYi1.to_f + (varRNc.to_f / 365)		#Convert it to a floating point integer

if varRNb == varRNc						#TB700	#If the record date falls after the query start date - continue
#if varRNb >= varRNc					#TB700
if row1[1] = 20									#If the agency is CAT - continue
if row1[3] == varRt1							#If route number = queried route - continue
if row1[5] == varStp1
varRnd = rand(1..vSS1)							#Create a sample ratio value
if varRnd == 1									#Sample that percentage of records
randfile.puts "#{row1[0]},#{row1[1]},#{row1[2]},#{row1[3]},#{row1[4]},#{row1[5]},#{row1[6]},#{row1[7]},#{row1[8]}"
end
end
end										#TB
end
end												
end												
end
end
end										#TB1
randfile.close
end
puts "cache done"
#/Create temp sample cache .txt file

#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "cache file created - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#/STATUS UPDATE

#DATA ANALYSIS & CHART CREATION
#begin 	#begin YEAR		Yi	#TB700
#begin 	#begin MONTH 	Mi	#TB700
#begin	#begin DAY		Di	#TB700
#puts "YMD - #{varYi1} #{varMi1} #{varDi1} "
list = CSV.foreach(cacheRand1) do |row|			# for each record in the cacheRand1

# Headers
# [0]..gendate
# [1]..agency
# [2]..route_id
# [3]..route_number
# [4]..route_name
# [5]..stop_id
# [6]..MinsToArriv
# [7]..lon
# [8]..lat

	varX = 0	#scatter chart x-axis time value
	varXh = 0
	varXm = 0
	varDate = 0
	varYer = 0
	varMon = 0
	varDay = 0
	varHr = 0
	varMin = 0
#	varRtnam = 0
#	varAgc = 0
#	varMins = 0
#	varWday = 0
#	varMins = row[3].to_f
#	varRtnam = row[9]#.to_a

	#PARSE TIME
	varDate = row[0]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
	varYer = varDate.year	#TB700
	varMon = varDate.month	#TB700
	varDay = varDate.day	#TB700
	varHr = varDate.hour
	varMin = varDate.minute
#	varXh = varHr.to_f
#	varXm = varMin.to_f
#	varX = varXh + (varXm /60)
	

#if varYer == varYi1	#TB700
#if varMon == varMi1+1	#TB700
#if varDay == varDi1	#TB700
#if varHr >= vHrMin		#TB700
#if varHr < vHrMax		#TB700
#arrCal << row[6].to_f		#TB700				#add MinsToArriv to array
#end						#TB700
#end						#TB700
#end					#TB700
#end					#TB700
#end					#TB700
File.open(cacheB1, "a+") do |cb1|
#cb1.puts "[#{varX},#{row[6]}],// stop_id: #{row[5]}"	#TB700
cb1.puts "[new Date(#{varYer}, #{varMon}, #{varDay}, #{varHr}, #{varMin}, 0), #{row[6]}],// stop_id: #{row[5]}"	#TB700
end
end


#CACHE_A
File.open(cacheA1, "a+") do |ca1|
	ca1.puts "<html>"
	ca1.puts "<head>"
	#ca1.puts "#{"<META HTTP-EQUIV="}#{'"'}#{"refresh"}#{'"'}#{" CONTENT="}#{'"'}#{30}#{'"'}#{">"}"#refresh code
	ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
	ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
	ca1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"
	ca1.puts "google.setOnLoadCallback(drawChart3);"
	ca1.puts "function drawChart3() {"
	ca1.puts "var data3 = google.visualization.arrayToDataTable(["
	ca1.puts "['Clock Face - Minute', 'Next Bus Wait - Minutes'],"
end

#CACHE_C
File.open(cacheC1, "a+") do |cc1|
	cc1.puts "]);"
	cc1.puts "var options3 = {"
	cc1.puts "title: 'Moore Square Station Next Bus Wait Time vs Time of Hour',"
	#cc1.puts "hAxis: {title: 'Clock Face - Minute', minValue: 0, maxValue: 59},"		#TB700
	#cc1.puts "hAxis: {title: 'Clock Face - Minute'},"									#TB700
	#cc1.puts "vAxis: {title: 'Next Bus Wait - Minutes', minValue: 0, maxValue: 59},"	#TB700
	#cc1.puts "vAxis: {title: 'Next Bus Wait - Minutes'},"								#TB700
	cc1.puts "curveType: 'none',"													#TB700		
	cc1.puts "explorer: { axis: 'horizontal' },"															#TB700
	cc1.puts "legend: 'none',"
	cc1.puts "pointSize: 7,"															#TB700
	cc1.puts "};"
	#cc1.puts "var chart3 = new google.visualization.ScatterChart(document.getElementById('chart_div3'));"	#TB700
	cc1.puts "var chart3 = new google.visualization.LineChart(document.getElementById('chart_div3'));"		#TB700
	cc1.puts "chart3.draw(data3, options3);"
	cc1.puts "}"
	cc1.puts "</script>"
	cc1.puts "</head>"
	cc1.puts "<body>"
	cc1.puts "#{"<div id="}#{'"'}#{"chart_div3"}#{'"'}#{" style="}#{'"'}#{"width: 1200px; height: 600px;"}#{'"'}#{"></div>"}"
	cc1.puts "</body>"
	cc1.puts "</html>"
	#cc1.puts "Average Wait: #{varRtAvgWait.round(1)} mins"
end

#cachework
File.open(calFull, "w+") do |zz1|
zz1.puts ""
end
hafile = File.open(cacheA1, "r")
hacontents = hafile.read
hafile.close
File.open(calFull, "a+") do |ha3|
ha3.puts hacontents
end
hbfile = File.open(cacheB1, "r")
hbcontents = hbfile.read
hbfile.close
File.open(calFull, "a+") do |ha4|
ha4.puts hbcontents
end
hcfile = File.open(cacheC1, "r")
hccontents = hcfile.read
hcfile.close
File.open(calFull, "a+") do |ha5|
ha5.puts hccontents
end
File.delete(cacheA1)
File.delete(cacheC1)

#arrCal = nil	#TB700
#arrCal = [0]	#TB700

#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "#{varYi1} #{varMi1} #{varDi1} iteration complete - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#STATUS UPDATE

=begin
varDi1 +=1;
end until varDi1 > 31	#/begin DAY
varDi1 = 1
varMi1 +=1;
end until varMi1 > 11	#/begin MONTH
varDi1 = 1
varMi1 = 0
varYi1 +=1;
end until varYi1 > 2015	#/begin YEAR
=end 
#/DATA ANALYSIS & CHART CREATION


#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "one more file parsed - duration #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#/STATUS UPDATE

#--CLEANUP--
File.delete(cacheB1)

=begin
fileCR=File.open(cacheRand1,"r")
puts ""
puts "#{fileCR.readlines.size} lines queried"
fileCR.close
=end

puts ""
varEn = Time.now
puts "Ended: #{varEn}" 
varDur = varEn - varSt	#seconds
puts ""
puts "Duration: #{varDur.round(1)} seconds"
exit
