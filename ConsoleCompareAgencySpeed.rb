# A SCRIPT THAT...
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


#FYI "agency_id" values for specific agencies
# C-Tran/Cary 		= 367
# DATA/Durham 		= 24
# CHT/Chapel Hill 	= 80
# DukeU 			= 176
# Wolfline/NCSU 	= 16
# TTA 				= 12
# Raleigh/CAT 		= 20

#REQUIRE STATEMENTS
require 'unirest'
require 'json'

#WRITE TO CONSOLE
puts "working"	#script is running
fname = "AgencySpeed_bus #{Time.now.strftime('%Y%m%d')}.txt"		#Creates a new .txt file in directory of .rb
gname = "AgencySpeed_avg #{Time.now.strftime('%Y%m%d')}.txt"		#Creates a new .txt file in directory of .rb
hname = "AgencySpeed_log #{Time.now.strftime('%Y%m%d')}.txt"		#Creates a new .txt file in directory of .rb
puts 'How long to sleep (in seconds) between each loop? (typically ~5)'
d = gets.to_i 															#delay in seconds between each repeat iteration
puts "\e[H\e[2J"
puts "#{d} seconds delay"
sleep(2)

#INITIAL VARIABLES
b = 0
c = "done"				#displayed in console to show that script is complete
e = "CAT mph = "
f = "TTA mph = "
w = "WLF mph = "

varTcumSpd = 0
varTcumCt = 0
varTcum = 0	
varCcumSpd = 0
varCcumCt = 0
varCcum = 0
varWcumSpd = 0
varWcumCt = 0
varWcum = 0	


varI = 0				#variable that represents starting integer for loop count
puts "\e[H\e[2J"
puts 'How many loops to perform? (typically ~10)'
varNum = gets.to_i         												#tracks number of repeat iterations, resets 
																		#	value to 0 
puts "\e[H\e[2J"
puts "#{varNum} loops"
sleep(2)

#SOMEFILE HEADER
File.open(fname, "a+") do |f1|
	f1.puts "time,agency,bus_id,mph,lon,lat,route,heading,segment_id"
end
File.open(gname, "a+") do |g7|
	g7.puts "time,agency,count_buses,mph"
end

#WRITE TO LOG FILE
File.open(hname, "a+") do |h2|
	h2.puts "###CONSOLE LOG FILE###"
	h2.puts ""
	h2.puts ""
	h2.puts "How long to sleep (in seconds) between each loop? (typically ~5)"
	h2.puts "#{d} seconds delay"
	h2.puts "How many loops to perform? (typically ~10)"
	h2.puts "#{varNum} loops"
end

#BEGIN FIRST ITERATION
begin
# variables
varI +=1;
varTime = "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')}"
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

# the mashape call to TransLoc api
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=12%2C16%2C20&callback=call",
  headers:{
    "X-Mashape-Key" => "<key>"
  }
#parse the call  
payload2 = response.body					#sets the call response body as a variable
payload = payload2[/{.+}/]					#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)				#parses the response body and stores as a variable

#loop through CAT parsed data to get the data you want
data_hash["data"]["20"].each do |ary|		#for each object in the array,
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

#write it to a file
File.open(fname, "a+") do |f4|
	f4.puts "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},CAT,#{varVID},#{varSpd.round(1)},#{varLng},#{varLat},#{varRt},#{varHd},#{varSeg}"
end
varSpd = 0
varVID = 0
varLng = 0
varLat = 0
varRt = 0
varHd = 0
varSeg = 0
end											#...end array loop

#loop through TTA parsed data to get the data you want
data_hash["data"]["12"].each do |aryt|		#for each object in the array,
varSpdt = aryt["speed"] * 0.621371			#set var for "speed" value in array, convert to mph
varVIDt = aryt["vehicle_id"]				#set var for "vehicle_id" value in array,
varLngt = aryt["location"]["lng"]			#set var for longitude value in array,
varLatt = aryt["location"]["lat"]			#set var for latitude value in array,
varRtt = aryt["route_id"]					#set var for route_id value in array
varHdt = aryt["heading"]						#set var for heading value in array
varSegt = aryt["segment_id"]					#set var for segment_id value in array
varCountt = varCountt + 1					#increase repeat iterations by 1,
varSumt = varSumt + varSpdt			#separately, set var for sum of all "speed" values in array,
varTcumSpd = varTcumSpd + varSpdt			#cumulative speed tracking
varTcumCt = varTcumCt + 1					#cumulative count tracking
File.open(fname, "a+") do |f5|
	f5.puts "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},TTA,#{varVIDt},#{varSpdt.round(1)},#{varLngt},#{varLatt},#{varRtt},#{varHdt},#{varSegt}"
end	
varSpdt = 0
varVIDt = 0
varLngt = 0
varLatt = 0
varRtt = 0
varHdt = 0
varSegt = 0
end											#...end array loop



#loop through WLF parsed data to get the data you want
data_hash["data"]["16"].each do |aryw|		#for each object in the array,
varSpdw = aryw["speed"] * 0.621371			#set var for "speed" value in array, convert to mph
varVIDw = aryw["vehicle_id"]				#set var for "vehicle_id" value in array,
varLngw = aryw["location"]["lng"]			#set var for longitude value in array,
varLatw = aryw["location"]["lat"]			#set var for latitude value in array,
varRtw = aryw["route_id"]					#set var for route_id value in array
varHdw = aryw["heading"]						#set var for heading value in array
varSegw = aryw["segment_id"]					#set var for segment_id value in array
varCountw = varCountw + 1					#increase repeat iterations by 1,
varSumw = varSumw + varSpdw			#separately, set var for sum of all "speed" values in array,
varWcumSpd = varWcumSpd + varSpdw			#cumulative speed tracking
varWcumCt = varWcumCt + 1					#cumulative count tracking
File.open(fname, "a+") do |f6|
	f6.puts "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},WLF,#{varVIDw},#{varSpdw.round(1)},#{varLngw},#{varLatw},#{varRtw},#{varHdw},#{varSegw}"
end	
varSpdw = 0
varVIDw = 0
varLngw = 0
varLatw = 0
varRtw = 0
varHdw = 0
varSegw = 0
end											#...end array loop





#write the data in the console	
varAvg = varSum / varCount					#calculate CAT instant average bus speed
varAvgt = varSumt / varCountt				#calculate TTA instant average bus speed
varAvgw	= varSumw / varCountw				#calculate WLF instant average bus speed
varTcum = varTcumSpd / varTcumCt			#calculate TTA cumulative avgerage bus speed
varCcum = varCcumSpd / varCcumCt			#calculate CAT cumulative average bus speed
varWcum = varWcumSpd / varWcumCt			#calculate WLF cumulative average bus speed
puts "\e[H\e[2J"							#clears console
#puts "Current Time: #{varTime}"				#current time
#puts "#{e} #{varAvg.round(1)} (#{varCcum.round(0)} cum.)"	#CAT speed data
#puts "#{f} #{varAvgt.round(1)} (#{varTcum.round(0)} cum.)"	#TTA speed data
#puts "#{w} #{varAvgw.round(1)} (#{varWcum.round(0)} cum.)"	#WLF speed data
#puts ""										
#puts "Variable Inputs:" 					#variable inputs
puts "Loop delay: #{d} seconds" 			#loop delay in seconds
puts "Iterations: #{varI} of #{varNum+1}"	#x of y count
puts""	
puts "(i)nstant / (a)verage Fleet Speed"									
puts "...|----5----10---15---20---25---30mph"	#instant bar graph
puts "CAT|#{"i" * varAvg.round(0)}"					#instant bar graph - cat
puts "   |#{"a" * varCcum.round(0)}"					#avg bar graph - cat
puts "TTA|#{"i" * varAvgt.round(0)}"					#instant bar graph - TTA
puts "   |#{"a" * varTcum.round(0)}"					#avg bar graph - TTA
puts "WLF|#{"i" * varAvgw.round(0)}"					#instant bar graph - WLF
puts "   |#{"a" * varWcum.round(0)}"					#avg bar graph - WLF
#puts""
#puts "Average Fleet Speed"									
#puts "   |----5----10---15---20---25---30mph"	#avg bar graph
#puts "CAT|#{"a" * varCcum.round(0)}"					#avg bar graph - cat
#puts "TTA|#{"a" * varTcum.round(0)}"					#avg bar graph - TTA
#puts "WLF|#{"a" * varWcum.round(0)}"					#avg bar graph - WLF
puts""
puts "Buses in Service"
puts "...|----10---20---30---40---50---60---70---80buses"	#bus count bar graph
puts "CAT|#{"*" * (varCount/2)}"
puts "TTA|#{"*" * (varCountt/2)}"
puts "WLF|#{"*" * (varCountw/2)}"

#WRITE TO SOMEFILE
File.open(gname, "a+") do |g2|
	g2.puts "#{varTime},CAT,#{varCount},#{varAvg.round(1)}"
end
File.open(gname, "a+") do |g3|
	g3.puts "#{varTime},TTA,#{varCountt},#{varAvgt.round(1)}"
end
File.open(gname, "a+") do |g4|
	g4.puts "#{varTime},WLF,#{varCountw},#{varAvgw.round(1)}"
end


File.open(hname, "a+") do |h1|
	h1.puts ""
	h1.puts ""
	h1.puts "Iteration: #{varI} of #{varNum+1}"		#x of y count
	h1.puts "Current Time: #{varTime}"				#current time
	h1.puts "#{e} #{varAvg.round(1)} (#{varCcum.round(1)} cumulative)"
	h1.puts "#{f} #{varAvgt.round(1)} (#{varTcum.round(1)} cumulative)"
	h1.puts "#{w} #{varAvgw.round(1)} (#{varWcum.round(1)} cumulative)"
end
sleep(d)
end until varI > varNum

#CLEANUP
puts c									#writes "done" to console
sleep(2)								#waits 10 seconds before closing console
exit
