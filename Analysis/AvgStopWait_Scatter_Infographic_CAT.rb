# A ruby script that post-processes [logged] real-time next bus arrival 
# data to create a scatter chart showing average wait in minutes for a 
# particular bus stop as a scatter chart during a queriedperiod of time.  
# X = time of day; Y = minutes to next bus arrival. You are able to 
# query specific stops and routes in the #INPUTS section of the code
# below

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
vHrMin = 7			# 7 = 0700 = 7am start	#TB
#---end-hour------------/
vHrMax = 17			# 9 = 1700 = 4:49pm end #TB
#---stop----------------/
#varStp1 = "4100198"	#4102202 = Peact St. at Seaboard Station, 4100198 == moore square station
#---route---------------/
varRt1 = "r-line"		
#---year----------------/
varYi1 = 2015 		#year increment start
#---month---------------/
varMi1 = 0 		#month increment start (0 = jan, 1 = feb, etc)
#---day-----------------/
varDi1 = 1			#day increment start
#---sample-size---------/
vSS1 = 100			#percent sample rate 1/x
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
calFull = "AvgStopWait_Cal_Infographic_CAT.html"		#chart output file
arrCal = [0]
arrCount = [0]						#counting how many lines in each file to filter out incomplete days
varI = 1
varDate=0
varYer = 0
varMon = 0
varDay = 0
varHr = 0
varMin = 0
varMia = varMi1 + 1		#logic that converts month integer back to true calendar (i.e. 12 = dec)
#vHrMin = vHrMin + 5		#sets the minimum and maximum start times query and ajdusts to GMT #TB
#vHrMax = vHrMax + 5		#sets the minimum and maximum start times query and ajdusts to GMT #TB
#varRtnam = 0
#varAgc = 0
#varMins = 0
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
=begin
#OTHER SETUP
arrTemp = "cal_temarray.txt"
if File.exists?(arrTemp)	
File.delete(arrTemp)
end
#/OTHER SETUP
=end
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

#puts "filename: #{foo}" 		#TB1
#puts varFooYr					#TB1
#puts varFooMo					#TB1
#puts varFooDa					#TB1


varFooC = Date.new(varFooYr,varFooMo,varFooDa).yday	#filename day of year	#TB1
varFooC = varFooYr.to_f + (varFooC.to_f / 365)		#TB1
varFooD = Date.new(varYi1,varMia,varDi1).yday		#day of year of query	#TB1
varFooD = varYi1.to_f + (varFooD.to_f / 365)		#TB1

if varFooC >= varFooD				#TB1
#puts "true - varFooC >= varFooD"
#puts "varFooC = #{varFooC}"		#TB1
#puts "varFooD = #{varFooD}"		#TB1
#sleep(100000)					#TB1										
#end



list = CSV.foreach(foo) do |row1|				#For each record in foo
varRN = row1[0]									#read an attribute of the record
if varRN == "gendate"							#if the line of the file is the header
else											#skip the line
varRNy = row1[0][0...4].to_i					#Manual parse to get the year of the record 
varRNm = row1[0][5...7].to_i					#Manual parse to get the month of the record
varRNd = row1[0][8...10].to_i					#Manual parse to get the day of the record
varRNh = row1[0][11...13].to_i					#Manual parse to get the hour of the record
#puts row1[0][11...13]					#TB
#sleep(100)								#TB

if varRNy > 0									#Error handling - if record is null just skip
varRNb = Date.new(varRNy,varRNm,varRNd).yday	#Get the day of year for the record
varRNb = varRNy.to_f + (varRNb.to_f / 365)		#Convert it to a floating point integer
varRNc = Date.new(varYi1,varMia,varDi1).yday		#Get the day of year for the query start date
varRNc = varYi1.to_f + (varRNc.to_f / 365)		#Convert it to a floating point integer

if varRNb >= varRNc								#If the record date falls after the query start date - continue
#if varRNh >= vHrMin						#TB
#if varRNh < vHrMax						#TB
if row1[1] = 20									#If the agency is CAT - continue
if row1[3] == varRt1					#TB
#if row1[5] == varStp1					#TB
#puts "true"							#TB
#sleep(100)								#TB
#if row1[0].include? "T08" 				#TB
varRnd = rand(1..vSS1)							#Create a sample ratio value
if varRnd == 1									#Sample that percentage of records
randfile.puts "#{row1[0]},#{row1[1]},#{row1[2]},#{row1[3]},#{row1[4]},#{row1[5]},#{row1[6]},#{row1[7]},#{row1[8]}"
end
#end									#TB
#end									#TB
end										#TB
end
#end										#TB
#end										#TB
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
begin 	#begin YEAR		Yi
begin 	#begin MONTH 	Mi
begin	#begin DAY		Di
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
	varYer = varDate.year
	varMon = varDate.month
	varDay = varDate.day
	varHr = varDate.hour
	varMin = varDate.minute
=begin #error checking.  
	puts "#{varDate.hour}:#{varDate.minute}" #time
	puts ""
	sleep(10)
=end
	
#	varWday = varDate.wday

if varYer == varYi1
if varMon == varMi1+1
if varDay == varDi1
#if row[1] == 20							#only write CAT buses - some old log files include TTA et. al. 
#if row[5] == varStp1						#TB - only write for queried stop
#if row[3] == varRt1						#TB - only write for queried route
#puts "true"			#TB
#sleep(100)				#TB
if varHr >= vHrMin		#TB
if varHr < vHrMax		#TB
arrCal << row[6].to_f						#add MinsToArriv to array
end						#TB
end						#TB
#end					#TB
#end					#TB
#end						
end
end
end
end
File.open(cacheB1, "a+") do |cb1|
if arrCal.mean > 0
cb1.puts "[ new Date(#{varYi1}, #{varMi1}, #{varDi1}), #{arrCal.mean.round(1)} ],  //Count: #{arrCal.count}"	#TODO - //count of records that day
end
end

#CACHE_A
File.open(cacheA1, "a+") do |ca1|
ca1.puts "<html>"
ca1.puts "<head>"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
ca1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1.1"}#{'"'}#{", {packages:["}#{'"'}#{"calendar"}#{'"'}#{"]"}#{'}'}#{");"}"
ca1.puts "#{"google.setOnLoadCallback(drawChart);"}"
ca1.puts "#{"function drawChart() {"}"	
ca1.puts "#{"var dataTable = new google.visualization.DataTable();"}"
ca1.puts "#{"dataTable.addColumn({ type: 'date', id: 'Date'});"}"
ca1.puts "#{"dataTable.addColumn({ type: 'number', id: 'Mins to next bus' });"}"
ca1.puts "#{"dataTable.addRows(["}"
end

#CACHE_C
File.open(cacheC1, "a+") do |cc1|
cc1.puts "#{"]);"}"
cc1.puts "#{"var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));"}"
cc1.puts "#{"var options = {"}"
cc1.puts "#{"title: "}#{'"'}#{"Minutes to Next Bus at All Stops on Route #"}#{varRt1}#{'"'}#{","}"
cc1.puts "#{"height: 350,"}"
cc1.puts "#{"colorAxis: {colors: ['pink', 'navy']},"}"
cc1.puts "#{"};"}"
cc1.puts "#{"chart.draw(dataTable, options);"}"
cc1.puts "}"
cc1.puts "</script>"
cc1.puts "</head>"
cc1.puts "<body>"
cc1.puts "#{"<div id="}#{'"'}#{"calendar_basic"}#{'"'}#{" style="}#{'"'}#{"width: 1000px; height: 350px;"}#{'"'}#{"></div>"}"
cc1.puts "</body>"
cc1.puts "</html>"
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

arrCal = nil
arrCal = [0]
#puts "array cleared"

#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "#{varYi1} #{varMi1} #{varDi1} iteration complete - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#STATUS UPDATE

varDi1 +=1;
end until varDi1 > 31	#/begin DAY
varDi1 = 1
varMi1 +=1;
end until varMi1 > 11	#/begin MONTH
varDi1 = 1
varMi1 = 0
varYi1 +=1;
end until varYi1 > 2015	#/begin YEAR
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
