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
#	xx12. add instant speed bar graph to console
#	xx.13. make r-line only

#REQUIRE STATEMENTS
require 'unirest'
require 'json'

#WRITE TO CONSOLE
puts "working"	#script is running
fname = "AgencySpeed_bus #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"		#Creates a new .txt file in directory of .rb
gname = "AgencySpeed_avg #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"		#Creates a new .txt file in directory of .rb
hname = "AgencySpeed_log #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"		#Creates a new .txt file in directory of .rb
puts 'How long to sleep (in seconds) between each loop? (typically ~5)'
d = gets.to_i 															#delay in seconds between each repeat iteration
puts "\e[H\e[2J"
puts "#{d} seconds delay"
sleep(2)

#INITIAL VARIABLES
b = 0
c = "done"				#displayed in console to show that script is complete
e = "R-Line mph = "

varTcumSpd = 0
varTcumCt = 0
varCcumSpd = 0
varCcumCt = 0
varTcum = 0		
varCcum = 0

#LOOP UNTIL
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
varCountt = 0
varCount = 0 								#Counts the number of buses that respond during 
											#	each iteration
varSumt = 0											
varSum = 0 									#The sum of the speed values for each responding 
											#	bus during each iteration
varAvgt = 0	
varAvg = 0									#A value derived from varSum divided by varCount 
											#	that equals the average speed for all responding 
											#	buses during each iteration

# the mashape call to TransLoc api
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=call&routes=4000032",
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
	f4.puts "#{Time.now.strftime('%H')}:#{Time.now.strftime('%M')}:#{Time.now.strftime('%S')},CAT,#{varVID},#{varSpd},#{varLng},#{varLat},#{varRt},#{varHd},#{varSeg}"
end
end											#...end array loop
	
#write the data in the console	
varAvg = varSum / varCount					#calculate CAT instant average bus speed
varCcum = varCcumSpd / varCcumCt			#calculate CAT cumulative average bus speed
puts "\e[H\e[2J"							#clears console
puts "#{e} #{varAvg.round(1)}"				#R-Line speed data
puts "Loop delay: #{d} seconds" 			#loop delay in seconds
puts "Iterations: #{varI} of #{varNum+1}"	#x of y count
puts ""										
puts "Speed Bar Graph"
puts "       |----5----10---15---20---25---30mph"	#instant bar graph
puts "instant|#{"*" * varAvg.round(0)}"				#instant bar graph - R-Line
puts "average|#{"*" * varCcum.round(0)}"

#WRITE TO SOMEFILE
File.open(gname, "a+") do |g2|
	g2.puts "#{varTime},CAT,#{varCount},#{varAvg}"
end

File.open(hname, "a+") do |h1|
	h1.puts ""
	h1.puts ""
	h1.puts "Iteration: #{varI} of #{varNum+1}"		#x of y count
	h1.puts "Current Time: #{varTime}"				#current time
	h1.puts "#{e} #{varAvg.round(1)} (#{varCcum.round(1)} cumulative)"
	#h1.puts "#{f} #{varAvgt.round(1)} (#{varTcum.round(1)} cumulative)"
end
sleep(d)
end until varI > varNum

#CLEANUP
puts c									#writes "done" to console
sleep(2)								#waits 10 seconds before closing console
exit