# A script that does statistical analysis on an array


require 'descriptive_statistics'
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'csv'
require 'time'
require 'date'
#require 'DateTime'

puts "\e[H\e[2J"
puts "Started: #{Time.now}"

#vars/defs
#SAfile = "CATAvgStopWait 20141202.txt"
#SAfile = Dir["CATAvgStopWait*.txt"]



#SETUP
#---month---/

#/SETUP


=begin
Dir.glob('CATAvgStopWait*.txt') do |foo|
puts "foo"
sleep(1)
end


arr1 = []	#am peak	7-8:59
arr2 = []	#mid-day	9-3:59
arr3 = []	#pm peak	4-5:59
arr4 = []	#late		6-12:59
arr5 = []	#All Day	0-24:59
=end

arr10 = []
arr11 = []
arr11L = []
arr12 = []
arr13 = []
arr15 = []
arr15L = []
arr16 = []
arr18 = []
arr2 = []
arr21 = []
arr23L = []
arr24L = []
arr25L = []
arr40X = []
arr6 = []
arr7 = []
arr70X = []
arr8 = []
arr22 = []
arr3 = []
arr55X = []
arr5 = []
arrrline = []
arr4 = []
arr7L = []
#arrwfl = []
arr31 = []
arr1 = []
arr19 = []
arr54L = []
#arr900 = []

var10 = "10"
var11 = "11"
var11L = "11L"
var12 = "12"
var13 = "13"
var15 = "15"
var15L = "15L"
var16 = "16"
var18 = "18"
var2 = "2"
var21 = "21"
var23L = "23L"
var24L = "24L"
var25L = "25L"
var40X = "40X"
var6 = "6"
var7 = "7"
var70X = "70X"
var8 = "8"
var22 = "22"
var3 = "3"
var55X = "55X"
var5 = "5"
varrline = "r-line"
var4 = "4"
var7L = "7L"
#varwfl = "wfl"
var31 = "31"
var1 = "1"
var19 = "19"
var54L = "54L"
#var900 = "900"

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

Dir.glob('CATAvgStopWait*.txt') do |foo|



list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var1					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr1 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var2					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr2 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var3					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr3 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var4					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr4 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var5					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr5 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var6					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr6 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var7					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr7 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var7L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr7L << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var8					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr8 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var10					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr10 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var11					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr11 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var11L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr11L << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var12					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr12 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var13					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr13 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var15					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr15 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var15L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr15L << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var16					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr16 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var18					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr18 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var19					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr19 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var21					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr21 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var22					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr22 << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var23L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr23L << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var24L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr24L << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var25L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr25L << row[6].to_f
	end
end
end

=begin
list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var31					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr31 << row[6].to_f
	end
end
end
=end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var40X					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr40X << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var54L					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr54L << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var55X					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr55X << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == var70X					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arr70X << row[6].to_f
	end
end
end

list =CSV.foreach(foo, :headers => true, :return_headers => false) do |row|
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
	if varRtnam == varrline					#query dependencies 
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
#	varHr = varDate.hour.to_f
#	varMin = varDate.minute
	#/PARSE TIME
	arrrline << row[6].to_f
	end
end
end

end
#puts arr1
puts "Average minutes to next bus arrival by route..."
#puts "##{varRtQuery}	#{arr5.mean}"
puts "##{var1}	#{arr1.mean}"
puts "##{var2}	#{arr2.mean}"
puts "##{var3}	#{arr3.mean}"
puts "##{var4}	#{arr4.mean}"
puts "##{var5}	#{arr5.mean}"
puts "##{var6}	#{arr6.mean}"
puts "##{var7}	#{arr7.mean}"
puts "##{var7L}	#{arr7L.mean}"
puts "##{var8}	#{arr8.mean}"
puts "##{var10}	#{arr10.mean}"
puts "##{var11}	#{arr11.mean}"
puts "##{var11L}	#{arr11L.mean}"
puts "##{var12}	#{arr12.mean}"
puts "##{var13}	#{arr13.mean}"
puts "##{var15}	#{arr15.mean}"
puts "##{var15L}	#{arr15L.mean}"
puts "##{var16}	#{arr16.mean}"
puts "##{var18}	#{arr18.mean}"
puts "##{var19}	#{arr19.mean}"
puts "##{var21}	#{arr21.mean}"
puts "##{var22}	#{arr22.mean}"
puts "##{var23L}	#{arr23L.mean}"
puts "##{var24L}	#{arr24L.mean}"
puts "##{var25L}	#{arr25L.mean}"
#puts "##{var31}	#{arr31.mean}"
puts "##{var40X}	#{arr40X.mean}"
puts "##{var54L}	#{arr54L.mean}"
puts "##{var55X}	#{arr55X.mean}"
puts "##{var70X}	#{arr70X.mean}"
#puts "##{var900}	#{arr900.mean}"
puts "##{varrline}	#{arrrline.mean}"
#puts "##{varwfl}	#{arrwfl.mean}"


#puts "% of Next Bus Arrivals in..."
# puts "AM Peak: #{arr1.mean} mins"
# puts "Mid-day: #{arr2.mean} mins"
# puts "PM Peak: #{arr3.mean} mins"
# puts "Evening: #{arr4.mean} mins"
#puts "..............24h..AMp..Mid..PMp..Eve...................."
#puts "<  2 minutes: #{arr5.percentile_rank(2).round(0)}%  #{arr1.percentile_rank(2).round(0)}%  #{arr2.percentile_rank(2).round(0)}%  #{arr3.percentile_rank(2).round(0)}%  #{arr4.percentile_rank(2).round(0)}%"
# puts "<  4 minutes: #{arr5.percentile_rank(4).round(0)}%  #{arr1.percentile_rank(4).round(0)}%  #{arr2.percentile_rank(4).round(0)}%  #{arr3.percentile_rank(4).round(0)}%  #{arr4.percentile_rank(4).round(0)}%"
# puts "<  6 minutes: #{arr5.percentile_rank(6).round(0)}%  #{arr1.percentile_rank(6).round(0)}%  #{arr2.percentile_rank(6).round(0)}%  #{arr3.percentile_rank(6).round(0)}%  #{arr4.percentile_rank(6).round(0)}%"
# puts "<  8 minutes: #{arr5.percentile_rank(8).round(0)}%  #{arr1.percentile_rank(8).round(0)}%  #{arr2.percentile_rank(8).round(0)}%  #{arr3.percentile_rank(8).round(0)}%  #{arr4.percentile_rank(8).round(0)}%"
# puts "< 10 minutes: #{arr5.percentile_rank(10).round(0)}%  #{arr1.percentile_rank(10).round(0)}%  #{arr2.percentile_rank(10).round(0)}%  #{arr3.percentile_rank(10).round(0)}%  #{arr4.percentile_rank(10).round(0)}%"
# puts "< 12 minutes: #{arr5.percentile_rank(12).round(0)}%  #{arr1.percentile_rank(12).round(0)}%  #{arr2.percentile_rank(12).round(0)}%  #{arr3.percentile_rank(12).round(0)}%  #{arr4.percentile_rank(12).round(0)}%"
# puts "< 14 minutes: #{arr5.percentile_rank(14).round(0)}%  #{arr1.percentile_rank(14).round(0)}%  #{arr2.percentile_rank(14).round(0)}%  #{arr3.percentile_rank(14).round(0)}%  #{arr4.percentile_rank(14).round(0)}%"
# puts "< 16 minutes: #{arr5.percentile_rank(16).round(0)}%  #{arr1.percentile_rank(16).round(0)}%  #{arr2.percentile_rank(16).round(0)}%  #{arr3.percentile_rank(16).round(0)}%  #{arr4.percentile_rank(16).round(0)}%"
# puts "< 18 minutes: #{arr5.percentile_rank(18).round(0)}%  #{arr1.percentile_rank(18).round(0)}%  #{arr2.percentile_rank(18).round(0)}%"
# puts "< 20 minutes: #{arr5.percentile_rank(20).round(0)}%  #{arr1.percentile_rank(20).round(0)}%  #{arr2.percentile_rank(20).round(0)}%"
# puts "< 22 minutes: #{arr5.percentile_rank(22).round(0)}%  #{arr1.percentile_rank(22).round(0)}%  #{arr2.percentile_rank(22).round(0)}%"
# puts "< 24 minutes: #{arr5.percentile_rank(24).round(0)}%  #{arr1.percentile_rank(24).round(0)}%  #{arr2.percentile_rank(24).round(0)}%"
# puts "< 26 minutes: #{arr5.percentile_rank(26).round(0)}%  #{arr1.percentile_rank(26).round(0)}%  #{arr2.percentile_rank(26).round(0)}%"
# puts "< 28 minutes: #{arr5.percentile_rank(28).round(0)}%  #{arr1.percentile_rank(28).round(0)}%  #{arr2.percentile_rank(28).round(0)}%"
# puts "< 30 minutes: #{arr5.percentile_rank(30).round(0)}%  #{arr1.percentile_rank(30).round(0)}%  #{arr2.percentile_rank(30).round(0)}%"

puts "Ended: #{Time.now}"

exit

