# A script that does statistical analysis on an array
require 'descriptive_statistics'
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'csv'
require 'time'
require 'date'
#require 'DateTime'
puts "\e[H\e[2J"
puts "ARRIVAL ESTIMATES STATS"
varSt = Time.now 
puts "Started: #{varSt}" 
puts ""
#vars/defs
#SAfile = "CATAvgStopWait 20141202.txt"
#SAfile = Dir["CATAvgStopWait*.txt"]
cacheRand = "cacheRand.txt"
varLNC = 0		#count of line numbers in all .txt files

#Count total lines in all .txt files
Dir.glob('CATAvgStopWait*.txt') do |cl1|
File.foreach(cl1).with_index { |line, line_num|
varLNC += 1;
}
end
#puts varLNC
#sleep(100)
#/Count total lines in all .txt files



#SETUP
#---month---------------/
#---hour----------------/
vLow = 0		# begin of time-of-day span in 24-hr clockface hours --> 6=6:00am, 13=1:00pm, etc.
vHig = 23 		# end   of time-of-day span in 24-hr clockface hours --> 6=6:59am, 13=1:59pm, etc.
#---day-of-week---------/
varWDs = 1				# START DAY RANGE; 	0 = Sun, 1 = Mon, etc..
varWDe = 5				# END DAY RANGE;	0 = Sun, 1 = Mon, etc..
#---sample-size---------/
vSS = 300				#desired sample size
#/SETUP


#OTHER SETUP
vSp = varLNC / vSS		#this is the random high value
#/OTHER SETUP
vPCT = (vSS.to_f / varLNC.to_f)
#puts vPCT
vPCT = vPCT * 100
#puts vPCT
vPCT = vPCT.round(1)
#puts vPCT

#HEADERS
puts "**************"
puts "Hours between #{vLow}:00 and #{vHig}:59"
puts "Days of Week: #{varWDs}-#{varWDe} (where 0 = Sun, 1 = Mon, etc...)"
puts "Population Size: #{varLNC}"
puts "Desired Sample Size: #{vSS}"
puts "Desired Sample: #{vPCT}% of population"
puts "Rand Between 1 and #{vSp}"
puts "**************"
puts ""
arr10 = [0]
arr11 = [0]
arr11L = [0]
arr12 = [0]
arr13 = [0]
arr15 = [0]
arr15L = [0]
arr16 = [0]
arr18 = [0]
arr2 = [0]
arr21 = [0]
arr23L = [0]
arr24L = [0]
arr25L = [0]
arr40X = [0]
arr6 = [0]
arr7 = [0]
arr70X = [0]
arr8 = [0]
arr22 = [0]
arr3 = [0]
#arr55X = [0]
arr5 = [0]
arrrline = [0]
arr4 = [0]
arr7L = [0]
#arrwfl = [0]
arr31 = [0]
arr1 = [0]
arr19 = [0]
arr54L = [0]
#arr900 = [0]
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


randfile = File.open(cacheRand, "a+")
	
File.foreach(foo).with_index { |line, line_num|
#vars
varRnd = 0
varRnd = rand(1..vSp)						#INPUT sampling percentage
if varRnd == 1
#puts "#{line_num}: #{line}"
randfile.puts line
#else 
#puts "false"
end
#sleep(1)
}
randfile.close



list = CSV.foreach(randfile) do |row|			#****




# Headers
# [0]..gendate
# [1]..agency
# [2]..route_id
# [3]..route_number
# [4]..route_name
# [5]..stop_id
# [6]..MinToArriv
# [7]..lon
# [8]..lat


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
	varWday = 0
	
#=end

#if varRnd = 1 

	varMins = row[6].to_f
	if varMins > 0
	#if row[6].to_f > 0
	varRtnam = row[3]#.to_a





#=begin
#	varAgc = row[1]
#	varSid = row[5]
#=end
	#PARSE TIME
	varDate = row[0]
	varDate = DateTime.parse(varDate)
	varDate = varDate.to_time.iso8601
	varDate = DateTime.parse(varDate)		#time is parsed and in local (gmt-5) format
#	varYer = varDate.year
#	varMon = varDate.month
#	varDay = varDate.day
	varWday = varDate.wday
	if varWday.between?(varWDs, varWDe)
#puts varDate								#****
	varHr = varDate.hour.to_f
#puts varHr									#****
	if varHr.between?(vLow, vHig)
#puts "true"								#****
#puts "Route: #{varRtnam}"					#****
#sleep(20)									#****
#=begin	
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
#=end
	
#	varMin = varDate.minute
	#/PARSE TIME
	#puts row[3].inspect()
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
#else puts "false"					#****
#sleep(0.05)							#****
	end
	end
end 
end						#****z
#end #
end
puts "Average minutes to next bus arrival by route..."
puts ""
puts "Route	Mean	StDev	Count"
puts "##{var1}	#{arr1.mean.round(1)}	#{arr1.standard_deviation.round(1)}	#{arr1.number.round(0)}" unless arr1==nil
puts "##{var2}	#{arr2.mean.round(1)}	#{arr2.standard_deviation.round(1)}	#{arr2.number.round(0)}" unless arr2==nil
puts "##{var3}	#{arr3.mean.round(1)}	#{arr3.standard_deviation.round(1)}	#{arr3.number.round(0)}" unless arr3==nil
puts "##{var4}	#{arr4.mean.round(1)}	#{arr4.standard_deviation.round(1)}	#{arr4.number.round(0)}" unless arr4==nil
puts "##{var5}	#{arr5.mean.round(1)}	#{arr5.standard_deviation.round(1)}	#{arr5.number.round(0)}" unless arr5==nil
puts "##{var6}	#{arr6.mean.round(1)}	#{arr6.standard_deviation.round(1)}	#{arr6.number.round(0)}" unless arr6==nil
puts "##{var7}	#{arr7.mean.round(1)}	#{arr7.standard_deviation.round(1)}	#{arr7.number.round(0)}" unless arr7==nil
puts "##{var7L}	#{arr7L.mean.round(1)}	#{arr7L.standard_deviation.round(1)}	#{arr7L.number.round(0)}" unless arr7L==nil
puts "##{var8}	#{arr8.mean.round(1)}	#{arr8.standard_deviation.round(1)}	#{arr8.number.round(0)}" unless arr8==nil
puts "##{var10}	#{arr10.mean.round(1)}	#{arr10.standard_deviation.round(1)}	#{arr10.number.round(0)}" unless arr10==nil
puts "##{var11}	#{arr11.mean.round(1)}	#{arr11.standard_deviation.round(1)}	#{arr11.number.round(0)}" unless arr11==nil
puts "##{var11L}	#{arr11L.mean.round(1)}	#{arr11L.standard_deviation.round(1)}	#{arr11L.number.round(0)}" unless arr11L==nil
puts "##{var12}	#{arr12.mean.round(1)}	#{arr12.standard_deviation.round(1)}	#{arr12.number.round(0)}" unless arr12==nil
puts "##{var13}	#{arr13.mean.round(1)}	#{arr13.standard_deviation.round(1)}	#{arr13.number.round(0)}" unless arr13==nil
puts "##{var15}	#{arr15.mean.round(1)}	#{arr15.standard_deviation.round(1)}	#{arr15.number.round(0)}" unless arr15==nil
puts "##{var15L}	#{arr15L.mean.round(1)}	#{arr15L.standard_deviation.round(1)}	#{arr15L.number.round(0)}" unless arr15L==nil
puts "##{var16}	#{arr16.mean.round(1)}	#{arr16.standard_deviation.round(1)}	#{arr16.number.round(0)}" unless arr16==nil
puts "##{var18}	#{arr18.mean.round(1)}	#{arr18.standard_deviation.round(1)}	#{arr18.number.round(0)}" unless arr18==nil
puts "##{var19}	#{arr19.mean.round(1)}	#{arr19.standard_deviation.round(1)}	#{arr19.number.round(0)}" unless arr19==nil
puts "##{var21}	#{arr21.mean.round(1)}	#{arr21.standard_deviation.round(1)}	#{arr21.number.round(0)}" unless arr21==nil
puts "##{var22}	#{arr22.mean.round(1)}	#{arr22.standard_deviation.round(1)}	#{arr22.number.round(0)}" unless arr22==nil
puts "##{var23L}	#{arr23L.mean.round(1)}	#{arr23L.standard_deviation.round(1)}	#{arr23L.number.round(0)}" unless arr23L==nil
puts "##{var24L}	#{arr24L.mean.round(1)}	#{arr24L.standard_deviation.round(1)}	#{arr24L.number.round(0)}" unless arr24L==nil
puts "##{var25L}	#{arr25L.mean.round(1)}	#{arr25L.standard_deviation.round(1)}	#{arr25L.number.round(0)}" unless arr25L==nil
#puts "##{var31}	#{arr31.mean.round(1)}	#{arr31.standard_deviation.round(1)}	#{arr31.number.round(0)}" unless arr31==nil
puts "##{var40X}	#{arr40X.mean.round(1)}	#{arr40X.standard_deviation.round(1)}	#{arr40X.number.round(0)}" unless arr40X==nil
puts "##{var54L}	#{arr54L.mean.round(1)}	#{arr54L.standard_deviation.round(1)}	#{arr54L.number.round(0)}" unless arr54L==nil
#puts "##{var55X}	#{arr55X.mean.round(1)}	#{arr55X.standard_deviation.round(1)}	#{arr55X.number.round(0)}" unless arr55X==nil
#puts "##{var70X}	#{arr70X.mean.round(1)}	#{arr70X.standard_deviation.round(1)}	#{arr70X.number.round(0)}" unless arr70X==nil
#puts "##{var900}	#{arr900.mean.round(1)}	#{arr900.standard_deviation.round(1)}	#{arr900.number.round(0)}" unless arr900==nil
puts "##{varrline}	#{arrrline.mean.round(1)}	#{arrrline.standard_deviation.round(1)}	#{arrrline.number.round(0)}" unless arrrline==nil
#puts "##{varwfl}	#{arrrwfl.mean.round(1)}	#{arrrwfl.standard_deviation.round(1)}	#{arrrwfl.number.round(0)}" unless arrrwfl==nil
varEn = Time.now
varDur = varEn - varSt	#seconds
varDur = varDur / 60	#minutes
puts ""
puts "Duration: #{varDur.round(1)} minutes"
fileCR=File.open(cacheRand,"r")
puts ""
puts "#{fileCR.readlines.size} lines queried"
fileCR.close
File.delete(cacheRand)
exit
