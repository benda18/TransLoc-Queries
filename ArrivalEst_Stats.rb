# A script that does statistical analysis on an array
require 'descriptive_statistics'
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'csv'
require 'time'
require 'date'
#require 'DateTime'
puts "\e[H\e[2J"
varSt = Time.now 
puts "Started: #{varSt}" 
puts ""
#vars/defs
#SAfile = "CATAvgStopWait 20141202.txt"
#SAfile = Dir["CATAvgStopWait*.txt"]
#SETUP
#---month---/
#---hour---/
vLow = 7		# begin of time-of-day span in 24-hr clockface hours --> 6=6:00am, 13=1:00pm, etc.
vHig = 7		# end   of time-of-day span in 24-hr clockface hours --> 6=6:59am, 13=1:59pm, etc.
#/SETUP
#HEADERS
puts "Hours between #{vLow}:00 and #{vHig}:59"
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
#arr55X = []
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
#var55X = "55X"
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
varct10 = 0
varct11 = 0
varct11L = 0
varct12 = 0
varct13 = 0
varct15 = 0
varct15L = 0
varct16 = 0
varct18 = 0
varct2 = 0
varct21 = 0
varct23L = 0
varct24L = 0
varct25L = 0
varct40X = 0
varct6 = 0
varct7 = 0
#varct70X = 0
varct8 = 0
varct22 = 0
varct3 = 0
varct55X = 0
varct5 = 0
varctrline = 0
varct4 = 0
varct7L = 0
#varctwfl = 0
varct31 = 0
varct1 = 0
varct19 = 0
varct54L = 0
#varct900 = 0

Dir.glob('CATAvgStopWait*.txt') do |foo|

# list1 =CSV.foreach(foo, :headers => true, :return_headers => false) do |row1|
# varRtnam = 0
# varRtnam = row1["route_number"]#.to_a
# if varRtnam == var10
# varct10 +=1;
# end
# if varRtnam == var11
# varct11 +=1;
# end
# if varRtnam == var11L
# varct11L +=1;
# end
# if varRtnam == var12
# varct12 +=1;
# end
# if varRtnam == var13
# varct13 +=1;
# end
# if varRtnam == var15
# varct15 +=1;
# end
# if varRtnam == var15L
# varct15L +=1;
# end
# if varRtnam == var16
# varct16 +=1;
# end
# if varRtnam == var18
# varct18 +=1;
# end
# if varRtnam == var2
# varct2 +=1;
# end
# if varRtnam == var21
# varct21 +=1;
# end
# if varRtnam == var23L
# varct23L +=1;
# end
# if varRtnam == var24L
# varct24L +=1;
# end
# if varRtnam == var25L
# varct25L +=1;
# end
# if varRtnam == var40X
# varct40X +=1;
# end
# if varRtnam == var6
# varct6 +=1;
# end
# if varRtnam == var7
# varct7 +=1;
# end
# # if varRtnam == var70X
# # varct70X +=1;
# # end
# if varRtnam == var8
# varct8 +=1;
# end
# if varRtnam == var22
# varct22 +=1;
# end
# if varRtnam == var3
# varct3 +=1;
# end
# # if varRtnam == var55X
# # varct55X +=1;
# # end
# if varRtnam == var5
# varct5 +=1;
# end
# if varRtnam == varrline
# varctrline +=1;
# end
# if varRtnam == var4
# varct4 +=1;
# end
# if varRtnam == var7L
# varct7L +=1;
# end
# # if varRtnam == varwfl
# # varctwfl +=1;
# # end
# if varRtnam == var31
# varct31 +=1;
# end
# if varRtnam == var1
# varct1 +=1;
# end
# if varRtnam == var19
# varct19 +=1;
# end
# if varRtnam == var54L
# varct54L +=1;
# end
# # if varRtnam == var900
# # varct900 +=1;
# # end
# end

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
	#PARSE TIME
	varDate = row["gendate"]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
	varHr = varDate.hour.to_f
	if varHr.between?(vLow, vHig)
=begin	
if varRtnam == var10
varct10 +=1;
end
if varRtnam == var11
varct11 +=1;
end
if varRtnam == var11L
varct11L +=1;
end
if varRtnam == var12
varct12 +=1;
end
if varRtnam == var13
varct13 +=1;
end
if varRtnam == var15
varct15 +=1;
end
if varRtnam == var15L
varct15L +=1;
end
if varRtnam == var16
varct16 +=1;
end
if varRtnam == var18
varct18 +=1;
end
if varRtnam == var2
varct2 +=1;
end
if varRtnam == var21
varct21 +=1;
end
if varRtnam == var23L
varct23L +=1;
end
if varRtnam == var24L
varct24L +=1;
end
if varRtnam == var25L
varct25L +=1;
end
if varRtnam == var40X
varct40X +=1;
end
if varRtnam == var6
varct6 +=1;
end
if varRtnam == var7
varct7 +=1;
end
# if varRtnam == var70X
# varct70X +=1;
# end
if varRtnam == var8
varct8 +=1;
end
if varRtnam == var22
varct22 +=1;
end
if varRtnam == var3
varct3 +=1;
end
# if varRtnam == var55X
# varct55X +=1;
# end
if varRtnam == var5
varct5 +=1;
end
if varRtnam == varrline
varctrline +=1;
end
if varRtnam == var4
varct4 +=1;
end
if varRtnam == var7L
varct7L +=1;
end
# if varRtnam == varwfl
# varctwfl +=1;
# end
if varRtnam == var31
varct31 +=1;
end
if varRtnam == var1
varct1 +=1;
end
if varRtnam == var19
varct19 +=1;
end
if varRtnam == var54L
varct54L +=1;
end	
=end
	
#	varMin = varDate.minute
	#/PARSE TIME
	#puts row["route_number"].inspect()
	#sleep(100)
	if varRtnam == var10					#query dependencies 
	arr10 << row[6].to_f
	end
	if varRtnam == var11
	arr11 << row[6].to_f
	end
	if varRtnam == var11L
	arr11L << row[6].to_f
	end
	if varRtnam == var12
	arr12 << row[6].to_f
	end
	if varRtnam == var13
	arr13 << row[6].to_f
	end
	if varRtnam == var15
	arr15 << row[6].to_f
	end	
	if varRtnam == var15L
	arr15L << row[6].to_f
	end	
	if varRtnam == var16
	arr16 << row[6].to_f
	end	
	if varRtnam == var18
	arr18 << row[6].to_f
	end	
	if varRtnam == var2
	arr2 << row[6].to_f
	end	
	if varRtnam == var21
	arr21 << row[6].to_f
	end	
	if varRtnam == var23L
	arr23L << row[6].to_f
	end		
	if varRtnam == var24L
	arr24L << row[6].to_f
	end	
	if varRtnam == var25L
	arr25L << row[6].to_f
	end	
	if varRtnam == var40X
	arr40X << row[6].to_f
	end	
	if varRtnam == var6
	arr6 << row[6].to_f
	end
	if varRtnam == var7
	arr7 << row[6].to_f
	end
	if varRtnam == var70X
	arr70X << row[6].to_f
	end
	if varRtnam == var8
	arr8 << row[6].to_f
	end
	if varRtnam == var22
	arr22 << row[6].to_f
	end
	if varRtnam == var3
	arr3 << row[6].to_f
	end
	# if varRtnam == var55X
	# arr55X << row[6].to_f
	# end
	if varRtnam == var5
	arr5 << row[6].to_f
	end
	if varRtnam == varrline
	arrrline << row[6].to_f
	end
	if varRtnam == var4
	arr4 << row[6].to_f
	end
	if varRtnam == var7L
	arr7L << row[6].to_f
	end
	# if varRtnam == varwfl
	# arrwfl << row[6].to_f
	# end
	if varRtnam == var31
	arr31 << row[6].to_f
	end
	if varRtnam == var1
	arr1 << row[6].to_f
	end
	if varRtnam == var19
	arr19 << row[6].to_f
	end
	if varRtnam == var54L
	arr54L << row[6].to_f
	end
	# if varRtnam == var900
	# arr900 << row[6].to_f
	# end
end
end
end
end
puts "Average minutes to next bus arrival by route..."
puts "##{var1}	#{arr1.mean.round(0)}" unless arr1==nil
puts "##{var2}	#{arr2.mean.round(0)}" unless arr2==nil
puts "##{var3}	#{arr3.mean.round(0)}" unless arr3==nil
puts "##{var4}	#{arr4.mean.round(0)}" unless arr4==nil
puts "##{var5}	#{arr5.mean.round(0)}" unless arr5==nil
puts "##{var6}	#{arr6.mean.round(0)}" unless arr6==nil
puts "##{var7}	#{arr7.mean.round(0)}" unless arr7==nil
puts "##{var7L}	#{arr7L.mean.round(0)}" unless arr7L==nil
puts "##{var8}	#{arr8.mean.round(0)}" unless arr8==nil
puts "##{var10}	#{arr10.mean.round(0)}" unless arr10==nil
puts "##{var11}	#{arr11.mean.round(0)}" unless arr11==nil
puts "##{var11L}	#{arr11L.mean.round(0)}" unless arr11L==nil
puts "##{var12}	#{arr12.mean.round(0)}" unless arr12==nil
puts "##{var13}	#{arr13.mean.round(0)}" unless arr13==nil
puts "##{var15}	#{arr15.mean.round(0)}" unless arr15==nil
puts "##{var15L}	#{arr15L.mean.round(0)}" unless arr15L==nil
puts "##{var16}	#{arr16.mean.round(0)}" unless arr16==nil
puts "##{var18}	#{arr18.mean.round(0)}" unless arr18==nil
puts "##{var19}	#{arr19.mean.round(0)}" unless arr19==nil
puts "##{var21}	#{arr21.mean.round(0)}" unless arr21==nil
puts "##{var22}	#{arr22.mean.round(0)}" unless arr22==nil
puts "##{var23L}	#{arr23L.mean.round(0)}" unless arr23L==nil
puts "##{var24L}	#{arr24L.mean.round(0)}" unless arr24L==nil
puts "##{var25L}	#{arr25L.mean.round(0)}" unless arr25L==nil
#puts "##{var31}	#{arr31.mean.round(0)}" unless arr31==nil
puts "##{var40X}	#{arr40X.mean.round(0)}" unless arr40X==nil
puts "##{var54L}	#{arr54L.mean.round(0)}" unless arr54L==nil
#puts "##{var55X}	#{arr55X.mean.round(0)}" unless arr55X==nil
#puts "##{var70X}	#{arr70X.mean.round(0)}" unless arr70X==nil
#puts "##{var900}	#{arr900.mean.round(0)}" unless arr900==nil
puts "##{varrline}	#{arrrline.mean.round(0)}" unless arrrline==nil
#puts "##{varwfl}	#{arrwfl.mean.round(0)}" unless arrwfl==nil
varEn = Time.now
varDur = varEn - varSt	#seconds
varDur = varDur / 60	#minutes
puts ""
puts "Duration: #{varDur.round(1)} minutes"
exit
