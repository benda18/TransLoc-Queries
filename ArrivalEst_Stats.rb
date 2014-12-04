# A script that does statistical analysis on an array


require 'descriptive_statistics'
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'csv'
require 'time'
require 'date'
#require 'DateTime'

puts "\e[H\e[2J"

#vars/defs
SAfile = "ArrivalEstArray.txt"

arr1 = []	#am peak	7-8:59
arr2 = []	#mid-day	9-3:59
arr3 = []	#pm peak	4-5:59
arr4 = []	#late		6-12:59
arr5 = []	#All Day	0-24:59

varI = 1
varDate=0
varYer = 0
varMon = 0
varDay = 0
varHr = 0
varMin = 0
varRtnam = 0
varAgc = 0
varRtQuery = "r-line" 	#INPUTS
varMins = 0

list =CSV.foreach(SAfile, :headers => true, :return_headers => false) do |row|
#=begin
	varDate=0
	varYer = 0
	varMon = 0
	varDay = 0
	varHr = 0
	varMin = 0
	varRtnam = 0
	varAgc = 0
	varMins = 0
#=end
	
	varMins = row["MinsToArriv"].to_f
	if varMins > 0
	
	varRtnam = row["route_number"]#.to_a
#=begin
#	varAgc = row["agency"]
#	varSid = row["stop_id"]
#=end	
	if varRtnam == varRtQuery					#query dependencies 
	#PARSE TIME
#=begin
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
	varHr = varDate.hour.to_f
#	varMin = varDate.minute
#=end
=begin
	puts "Year: #{varYer}"
	puts "Month: #{varMon}"
	puts "Day: #{varDay}"
	puts "Hour: #{varHr}"
	puts "Minute: #{varMin}"
	sleep(10)
=end	
	#/PARSE TIME

	
	if varHr.between?(7, 8)	
		arr1 << row[6].to_f
	elsif varHr.between?(9, 15)
		arr2 << row[6].to_f	
	elsif varHr.between?(16, 17)	
		arr3 << row[6].to_f	
	elsif varHr.between?(18, 24)	
		arr4 << row[6].to_f		
	#puts "#{varRtnam}, #{row[6]} --- #{varI}"
	#arr1 << row[6].to_f						#creates array of MinsToArriv for query
	end	
	arr5 << row[6].to_f
	
	end
end
end
#puts arr1
puts "Route #: #{varRtQuery}"
puts "AM Peak: #{arr1.mean} mins"
puts "Mid-day: #{arr2.mean} mins"
puts "PM Peak: #{arr3.mean} mins"
puts "Evening: #{arr4.mean} mins"
puts "All Day: #{arr5.mean} mins"

exit
