# A script that does statistical analysis on an array
#To-Do - integrate with other scripts - this is good. 

require 'descriptive_statistics'	
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'CSV'
require 'time'
require 'date'

#INPUTS
#---year----------------/
varYi = 2014 	#year increment start
#---month---------------/
varMi = 11 		#month increment start (0 = jan, 1 = feb, etc)
#---day-----------------/
varDi = 3		#day increment start
#---sample-size---------/
vSS = 500		#percent sample rate 1/x
#/INPUTS

#vars/defs
cacheRand = "cacheRandAE2.txt"
# if File.exists?(cacheRand)	
# File.delete(cacheRand)
# end
cacheA = "cacheA.txt"
if File.exists?(cacheA)	
File.delete(cacheA)
end
cacheB = "cacheB.txt"
if File.exists?(cacheB)	
File.delete(cacheB)
end
cacheC = "cacheC.txt"
if File.exists?(cacheC)	
File.delete(cacheC)
end
calFull = "FleetSpeed_Candlestick_Infographic_CAT.html"		#chart output file
arrCal = [0]
varI = 1
varDate=0
varYer = 0
varMon = 0
varDay = 0
varHr = 0
varMin = 0
#varRtnam = 0
#varAgc = 0
#varMins = 0
#/vars/defs

#HEADERS
puts "\e[H\e[2J"
puts "FleetSpeed_Candlestick_Infographic_CAT.rb"
varSt = Time.now 
varLast = varSt
puts "Started: #{varSt}" 
puts ""
#Count total lines in all .txt files
varLNC = 0		#count of line numbers in all .txt files
Dir.glob('VehicleSpeed_bus*.txt') do |cl1|
File.foreach(cl1).with_index { |line, line_num|
varLNC += 1;
}
end
#/Count total lines in all .txt files
puts "**************"
puts "Start Date: #{varYi}-#{varMi}-#{varDi}"
puts "Population Size: #{varLNC}"
puts "Desired Sample: 1/#{vSS} of population"
puts "**************"
puts ""
#/HEADERS

#Create temp sample cache .txt file
if File.exists?(cacheRand)	
File.delete(cacheRand)
end
Dir.glob('VehicleSpeed_bus*.txt') do |foo|
randfile = File.open(cacheRand, "a+")
list = CSV.foreach(foo) do |row1|
varRN = row1[9]
varSegID = row1[8]
if varSegID == nil
else
# if varRN == "r-line"
if varRN == "rt_short_name"
else
varRnd = rand(1..vSS)						#INPUT sampling percentage
if varRnd == 1
randfile.puts "#{row1[0]},#{row1[1]},#{row1[2]},#{row1[3]},#{row1[4]},#{row1[5]},#{row1[6]},#{row1[7]},#{row1[8]},#{row1[9]},#{row1[10]}"
#randfile.puts "#{row1[0]},,,#{row1[3]},,,#{row1[6]},,#{row1[8]},#{row1[9]},"
end
end
end
end
randfile.close
end
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
puts "YMD - #{varYi} #{varMi} #{varDi} "
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

#PARSE TIME
varDate = row[0]
varDate = DateTime.parse(varDate)
varDate = varDate.to_time.iso8601
varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
varYer = varDate.year
varMon = varDate.month
varDay = varDate.day

if varYer == varYi
if varMon == varMi+1
if varDay == varDi
if row[3].to_f <= 0
else
arrCal << row[3].to_f
end
end
end
end
end

=begin
#TESTING
counts = Hash.new 0
arrCal.each do |nums|
counts[nums] += 1
end
puts counts
sleep(1000)
#/TESTING
=end


File.open(cacheB, "a+") do |cb1|
if arrCal.max > 0
# ['<date>', <min>, <25%>, <75%>, <max>]
cb1.puts "['#{varYi}-#{varMi+1}-#{varDi}', #{arrCal.min.round(1)}, #{arrCal.percentile(25).round(1)}, #{arrCal.percentile(75).round(1)}, #{arrCal.max.round(1)}, #{arrCal.mean.round(1)}], //#{arrCal.number}" 
=begin
varIQR = arrCal.percentile(75) - arrCal.percentile(25)
varNmin = arrCal.percentile(25) - (1.5 * (arrCal.percentile(75) - arrCal.percentile(25)))
varNmax = arrCal.percentile(75) + (1.5 * (arrCal.percentile(75) - arrCal.percentile(25)))
puts "Min: #{arrCal.min.round(1)}"
puts "Q1: #{arrCal.percentile(25).round(1)}"
puts "Median: #{arrCal.median.round(1)}"
puts "Q3: #{arrCal.percentile(75).round(1)}"
puts "Max: #{arrCal.max.round(1)}"
puts ""
puts "IQR: #{varIQR.round(1)}"
puts ""
puts "Min: #{varNmin.round(1)}"
puts "Q1: #{arrCal.percentile(25).round(1)}"
puts "Median: #{arrCal.median.round(1)}"
puts "Q3: #{arrCal.percentile(75).round(1)}"
puts "Max: #{varNmax.round(1)}"
cb1.puts "['#{varYi}-#{varMi+1}-#{varDi}', #{varNmin.round(1)}, #{arrCal.percentile(25).round(1)}, #{arrCal.percentile(75).round(1)}, #{varNmax.round(1)}, #{arrCal.mean.round(1)}], //#{arrCal.number}" 
=end
end
end

#CACHE_A
File.open(cacheA, "a+") do |ca1|
ca1.puts "<html>"
ca1.puts "<head>"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{" src="}#{'"'}#{"https://www.google.com/jsapi"}#{'"'}#{"></script>"}"
ca1.puts "#{"<script type="}#{'"'}#{"text/javascript"}#{'"'}#{">"}"
ca1.puts "#{"google.load("}#{'"'}#{"visualization"}#{'"'}#{", "}#{'"'}#{"1"}#{'"'}#{", {packages:["}#{'"'}#{"corechart"}#{'"'}#{"]"}#{'}'}#{");"}"
ca1.puts "#{"google.setOnLoadCallback(drawChart);"}"
ca1.puts "#{"function drawChart() {"}"	
ca1.puts "#{"var data = new google.visualization.arrayToDataTable(["}"
#ca1.puts "#{"dataTable.addColumn({ type: 'date', id: 'Date'});"}"
#ca1.puts "#{"dataTable.addColumn({ type: 'number', id: 'Won/Loss' });"}"
#ca1.puts "#{"dataTable.addRows(["}"
end

#CACHE_C
File.open(cacheC, "a+") do |cc1|
cc1.puts "#{"], true);"}"
cc1.puts "#{"var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));"}"
cc1.puts "#{"var options = {"}"
cc1.puts "#{"legend: 'none',"}"
cc1.puts "#{"title: 'CAT Average Observed Daily Fleet Speed (mins) - Quartiles',"}"
cc1.puts "#{"vAxis: {title: "}#{'"'}#{"Speed (MPH)"}#{'"'}#{"},"}"
cc1.puts "#{"seriesType: "}#{'"'}#{"candlesticks"}#{'"'}#{","}"
cc1.puts "#{"series: {1: {type: "}#{'"'}#{"area"}#{'"'}#{"}}"}"
cc1.puts "#{"};"}"
cc1.puts "#{"chart.draw(data, options);"}"
cc1.puts "}"
cc1.puts "</script>"
cc1.puts "</head>"
cc1.puts "<body>"
cc1.puts "#{"<div id="}#{'"'}#{"chart_div"}#{'"'}#{" style="}#{'"'}#{"width: 1300px; height: 500px;"}#{'"'}#{"></div>"}"
cc1.puts "</body>"
cc1.puts "</html>"
end

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
File.delete(cacheA)
File.delete(cacheC)

arrCal = nil
arrCal = [0]
puts "array cleared"

#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "day iteration complete - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#STATUS UPDATE

varDi +=1;
end until varDi > 31	#/begin DAY
varDi = 1
varMi +=1;
end until varMi > 11	#/begin MONTH
varDi = 1
varMi = 0
varYi +=1;
end until varYi > 2015	#/begin YEAR
#/DATA ANALYSIS & CHART CREATION


#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "one more file parsed - duration #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#/STATUS UPDATE

#--CLEANUP--
File.delete(cacheB)
puts ""
varEn = Time.now
puts "Ended: #{varEn}" 
varDur = varEn - varSt	#seconds
puts ""
puts "Duration: #{varDur.round(1)} seconds"
exit
