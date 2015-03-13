# A ruby script that post-processes real-time vehicle speed data
# to create a csv file (.txt) for input into GIS that shows
# vehicle speed (mph) by route and segment  

# Place this script in the same directory as your vehicle speed 
# data named VehicleSpeed_bus*.txt. Under INPUTS below enter the 
# start date that you want to query from. 

require 'descriptive_statistics'	
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'CSV'
require 'time'
require 'date'

#INPUTS
#---route----------------/
varRt = "15"		#route 
#---year----------------/
varYi = "2015" 		#year 
#---month---------------/
varMi = "01" 		#month  ("01" = jan, "02" = feb, etc)
#---day-----------------/
varDi = "01"		#day 
#---hour-start-----------------/
varHrS = 7			#hour start 7 = 7:00am
#---hour-end-----------------/
varHrE = 17			#hour end  17 = 5:59pm
#/INPUTS

#vars/defs
outputCSV = "SegmentOutput#{varYi}#{varMi}_#{varRt}.txt"
if File.exists?(outputCSV)	
File.delete(outputCSV)
end
outputfile = File.open(outputCSV, "a+")			#Open the cache file
outputfile.puts "mph,lon,lat,route,segment"		#write header
outputfile.close
varDate = 0
varHr = 0
varMin = 0
#/vars/defs

#HEADERS
puts "\e[H\e[2J"
puts "Segment_Speed_Filter_GIS.rb"
varSt = Time.now 
varLast = varSt
puts "Started: #{varSt}" 
puts ""
puts "**************"
puts "Query Date: #{varYi}-#{varMi}-#{varDi}"
puts "**************"
puts ""
#/HEADERS

#Create .txt file
varFileName = "VehicleSpeed_bus #{varYi}#{varMi}*.txt"
Dir.glob(varFileName) do |foo|					#For each file named 'Vehicle...txt" read as foo
outputfile = File.open(outputCSV, "a+")			#Open the cache file

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

varDate = 0
varHr = 0
varMin = 0
	
list = CSV.foreach(foo) do |row1|				#For each record in foo
varDate = row1[0]								#read an attribute of the record
if varDate == "gendate"							#if the line of the file is the header
else											#skip the line or else...

#PARSE TIME
varDate = row1[0]
varDate = DateTime.parse(varDate)
varDate = varDate.to_time.iso8601
varDate = DateTime.parse(varDate)				#time is parsed and in local (gmt-5/4) format
varHr = varDate.hour
varMin = varDate.min
#/PARSE TIME
	
if varDate.year > 0								#Error handling - if record is null just skip
if row1[8].to_i > 0								#if segment_id is not null
if row1[1] = "CAT"								#If the agency is CAT - continue
if row1[9].to_s == varRt.to_s					#If route_id = query input
if varHr.to_i >= varHrS.to_i
if varHr.to_i <= varHrE.to_i
outputfile.puts "#{row1[3]},#{row1[4]},#{row1[5]},#{row1[9]},#{row1[8]}"
end
end
end
end
end												
end												
end
end
outputfile.close
end
#/Create .txt file

#STATUS UPDATE
varNow = Time.now
varNow1 = varNow - varLast
puts "outputCSVAE2.txt created - duration:  #{varNow1.round(0)} seconds lapsed"
varLast = varNow
#/STATUS UPDATE

#--CLEANUP--
puts ""
varEn = Time.now
puts "Ended: #{varEn}" 
varDur = varEn - varSt							#seconds
puts ""
puts "Duration: #{varDur.round(1)} seconds"
exit
