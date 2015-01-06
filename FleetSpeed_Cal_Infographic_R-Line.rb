# A script that does statistical analysis on an array
require 'descriptive_statistics'	# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'csv'
require 'time'
require 'date'
puts "\e[H\e[2J"
puts "ARRIVAL ESTIMATES STATS"
varSt = Time.now 
varLast = varSt
puts "Started: #{varSt}" 
puts ""
#vars/defs
cacheRand = "cacheRandAE1.txt"
if File.exists?(cacheRand)	
File.delete(cacheRand)
end
varLNC = 0		#count of line numbers in all .txt files

cacheA = "cacheA.txt"
cacheB = "cacheB.txt"
cacheC = "cacheC.txt"
calFull = "R-LineSpeedCal.html"

#Count total lines in all .txt files
Dir.glob('VehicleSpeed_bus*.txt') do |cl1|
File.foreach(cl1).with_index { |line, line_num|
varLNC += 1;
}
end
# varNow = Time.now - varSt
# puts "done counting lines - duration #{varNow.round(1)} seconds lapsed"
#/Count total lines in all .txt files

=begin
#CACHE_A
File.open(cacheA, "a+") do |ca1|
ca1.puts "<html>"
ca1.puts "<head>"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
ca1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1.1"}#{'"'}#{", {packages:["}#{'"'}#{"calendar"}#{'"'}#{"]"}#{'}'}#{");"}"
ca1.puts "#{"google.setOnLoadCallback(drawChart);"}"
ca1.puts "#{"function drawChart() {"}"	
ca1.puts "#{"var dataTable = new google.visualization.DataTable();"}"
ca1.puts "#{"dataTable.addColumn({ type: 'date', id: 'Date'});"}"
ca1.puts "#{"dataTable.addColumn({ type: 'number', id: 'Won/Loss' });"}"
ca1.puts "#{"dataTable.addRows(["}"
end
#CACHE_C
File.open(cacheC, "a+") do |cc1|
cc1.puts "#{"]);"}"
cc1.puts "#{"var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));"}"
cc1.puts "#{"var options = {"}"
cc1.puts "#{"title: "}#{'"'}#{"R-Line Avg. Fleet Speed (mph)"}#{'"'}#{","}"
cc1.puts "#{"height: 350,"}"
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
# varNow = Time.now - varSt
# puts "done cacheA & cacheB - duration #{varNow.round(1)} seconds lapsed"
=end

#INPUTS
#---year----------------/
#---month---------------/
#---hour----------------/
#vLow = 0		# begin of time-of-day span in 24-hr clockface hours --> 6=6:00am, 13=1:00pm, etc.
#vHig = 23 		# end   of time-of-day span in 24-hr clockface hours --> 6=6:59am, 13=1:59pm, etc.
#---day-of-week---------/
#varWDs = 0				# START DAY RANGE; 	0 = Sun, 1 = Mon, etc..
#varWDe = 6				# END DAY RANGE;	0 = Sun, 1 = Mon, etc..
#---sample-size---------/
#vSS = 1000				#desired sample size
#/INPUTS


#OTHER SETUP
#vSp = varLNC / vSS		#this is the random high value
# vPCT = (vSS.to_f / varLNC.to_f)
# vPCT = vPCT * 100
# vPCT = vPCT.round(1)
arrTemp = "cal_temarray.txt"
if File.exists?(arrTemp)	
File.delete(arrTemp)
end
#File.open(arrTemp, "a+") do |at1|
#at1.puts "day,hour,minute,stop_id,route,MinToArriv"
#end
#/OTHER SETUP


#HEADERS
puts "**************"
#puts "Hours between #{vLow}:00 and #{vHig}:59"
#puts "Days of Week: #{varWDs}-#{varWDe} (where 0 = Sun, 1 = Mon, etc...)"
puts "Population Size: #{varLNC}"
#puts "Desired Sample Size: #{vSS}"
#puts "Desired Sample: #{vPCT}% of population"
#puts "Rand Between 1 and #{vSp}"
puts "**************"
puts ""

#arrRline = [0]
varRline = "r-line"
arrCal = [0]

varI = 1
varDate=0
varYer = 0
varMon = 0
varDay = 0
varHr = 0
varMin = 0
varRtnam = 0
varAgc = 0
#varRtQuery = "r-line" 	#INPUTS
varMins = 0

# varNow = Time.now - varSt
# puts "done VARS - duration #{varNow.round(1)} seconds lapsed"

Dir.glob('VehicleSpeed_bus*.txt') do |foo|

#=begin
randfile = File.open(cacheRand, "a+")
list = CSV.foreach(foo) do |row1|
varRN = row1[9]
if varRN == "r-line"
varRnd = rand(1..4)						#INPUT sampling percentage
if varRnd == 1
randfile.puts "#{row1[0]},#{row1[1]},#{row1[2]},#{row1[3]},#{row1[4]},#{row1[5]},#{row1[6]},#{row1[7]},#{row1[8]},#{row1[9]},#{row1[10]}"
end
end
end
randfile.close
#=end
end

varNow = Time.now
varNow1 = varNow - varLast
puts "cache file created - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow


varYi = 2014 	#year increment start
varMi = 11 		#month increment start (0 = jan, 1 = feb, etc)
varDi = 1		#day increment start


begin

puts varDi
list = CSV.foreach(cacheRand) do |row|			#****

# Headers
# [0]..gendate
# [1]..agency
# [2]..bus_id
# [3]..mph
# [4]..lon
# [5]..lat
# [6]..route_id
# [7]..heading
# [8]..segment_id
# [9]..rt_short_name
# [10].rt_long_name

	varDate=0
	varYer = 0
	varMon = 0
	varDay = 0
	varHr = 0
	varMin = 0
	varRtnam = 0
	varAgc = 0
	varMins = 0
	varWday = 0
	varMins = row[3].to_f
	if varMins > 0
	#if row[6].to_f > 0
	varRtnam = row[9]#.to_a

	#PARSE TIME
	varDate = row[0]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
	varYer = varDate.year
	varMon = varDate.month
	varDay = varDate.day
	varMin = varDate.minute.to_f
	varWday = varDate.wday
#	if varWday.between?(varWDs, varWDe)
	varHr = varDate.hour.to_f
#	if varHr.between?(vLow, vHig)

if varDay == varDi
#if varRtnam == varRline					#query dependencies 
arrCal << row[3].to_f
#end
end
end
end
File.open(cacheB, "a+") do |cb1|
if arrCal.mean > 0
cb1.puts "[ new Date(#{varYi}, #{varMi}, #{varDi}), #{arrCal.mean.round(1)} ],"
end
end
#CACHE_A
File.open(cacheA, "a+") do |ca1|
ca1.puts "<html>"
ca1.puts "<head>"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
ca1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1.1"}#{'"'}#{", {packages:["}#{'"'}#{"calendar"}#{'"'}#{"]"}#{'}'}#{");"}"
ca1.puts "#{"google.setOnLoadCallback(drawChart);"}"
ca1.puts "#{"function drawChart() {"}"	
ca1.puts "#{"var dataTable = new google.visualization.DataTable();"}"
ca1.puts "#{"dataTable.addColumn({ type: 'date', id: 'Date'});"}"
ca1.puts "#{"dataTable.addColumn({ type: 'number', id: 'Won/Loss' });"}"
ca1.puts "#{"dataTable.addRows(["}"
end
#CACHE_C
File.open(cacheC, "a+") do |cc1|
cc1.puts "#{"]);"}"
cc1.puts "#{"var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));"}"
cc1.puts "#{"var options = {"}"
cc1.puts "#{"title: "}#{'"'}#{"R-Line Avg. Fleet Speed (mph)"}#{'"'}#{","}"
cc1.puts "#{"height: 350,"}"
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
# varNow = Time.now - varSt
# puts "done cacheA & cacheB - duration #{varNow.round(1)} seconds lapsed"

#cachework
File.open(calFull, "w+") do |zz1|
zz1.puts ""
end
hafile = File.open(cacheA, "r")
hacontents = hafile.read
hafile.close
File.open(calFull, "a+") do |ha3|
ha3.puts hacontents
end

hbfile = File.open(cacheB, "r")
hbcontents = hbfile.read
hbfile.close
File.open(calFull, "a+") do |ha4|
ha4.puts hbcontents
end
hcfile = File.open(cacheC, "r")
hccontents = hcfile.read
hcfile.close
File.open(calFull, "a+") do |ha5|
ha5.puts hccontents
end
#--CLEANUP--
File.delete(cacheA)
#File.delete(cacheB)
File.delete(cacheC)




arrCal = nil
arrCal = [0]
puts "array cleared"
varNow = Time.now
varNow1 = varNow - varLast
puts "day iteration complete - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow
varDi +=1;
end until varDi > 31


varNow = Time.now
varNow1 = varNow - varLast
puts "one more file parsed - duration #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#end 

=begin
#cachework
File.open(calFull, "w+") do |zz1|
zz1.puts ""
end
hafile = File.open(cacheA, "r")
hacontents = hafile.read
hafile.close
File.open(calFull, "a+") do |ha3|
ha3.puts hacontents
end

hbfile = File.open(cacheB, "r")
hbcontents = hbfile.read
hbfile.close
File.open(calFull, "a+") do |ha4|
ha4.puts hbcontents
end
hcfile = File.open(cacheC, "r")
hccontents = hcfile.read
hcfile.close
File.open(calFull, "a+") do |ha5|
ha5.puts hccontents
end
#--CLEANUP--
File.delete(cacheA)
File.delete(cacheC)
=end
File.delete(cacheB)




fileCR=File.open(cacheRand,"r")
puts ""
puts "#{fileCR.readlines.size} lines queried"
fileCR.close
#File.delete(cacheRand)
puts ""
varEn = Time.now
puts "Ended: #{varEn}" 
varDur = varEn - varSt	#seconds
puts ""
puts "Duration: #{varDur.round(1)} seconds"
exit
