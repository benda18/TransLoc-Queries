# A script that does something
#REQUIRE STATEMENTS
require 'unirest'
require 'json'
#INITIAL VARIABLES
a = "working" 	#displayed in console to show that the script is running
b = 0         	#number of repeat iterations, resets value to 0 
c = "done"		#displayed in console to show that script is complete
d = 1 			#delay in seconds between each repeat iteration
#WRITE TO CONSOLE
puts a			#script is running


#BEGIN FIRST ITERATION
# variables
varCount = 0 														#Counts the number of buses that respond during 
																	#	each iteration
varSum = 0 															#The sum of the speed values for each responding 
																	#	bus during each iteration
varAvg = 0															#A value derived from varSum divided by varCount 
																	#	that equals the average speed for all responding 
																	#	buses during each iteration
fname = "CAT Parse #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"		#Creates a new .txt file in directory of .rb
somefile = File.open(fname, "w")									#Opens a writable copy of fname.txt
# the mashape call to TransLoc api
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=call",
  headers:{
    "X-Mashape-Key" => "5SA6zZbMxpmshjhL0Y8ERCZ2WqnIp1zgKOmjsnXy5WDKmZaGC4"
  }
#parse the call  
payload2 = response.body				#sets the call response body as a variable
payload = payload2[/{.+}/]				#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)			#parses the response body and stores as a variable
#loop through parsed data to get the data you want
data_hash["data"]["20"].each do |ary|	#for each object in the array,
varSpd = ary["speed"]					#set var for "speed" value in array,
varCount = varCount + 1					#increase repeat iterations by 1,
varSum = varSum + ary["speed"]			#separately, set var for sum of all "speed" values in array,
end										#...end array loop
#write the data somewhere
somefile.puts "Average MPH"				#write "Average MPH" header to the .txt file
varAvg = varSum / varCount				#calculate the average bus speed
somefile.puts varAvg.round(1)			#write the average bus speed to the .txt file
#log to console
b = b + 1								#represents the nth repeat iteration
puts b									#writes nth repeat iteration to console 


#BEGIN NEXT REPEAT ITERATION
#wait 
sleep(d)															#wait (d) seconds to begin next repeat iteration
#variables				
varCount = 0 														#Counts the number of buses that respond during 
																	#	each iteration
varSum = 0 															#The sum of the speed values for each responding 
																	#	bus during each iteration
varAvg = 0															#A value derived from varSum divided by varCount 
																	#	that equals the average speed for all responding 
																	#	buses during each iteration

# the mashape call to TransLoc api
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=call",
  headers:{
    "X-Mashape-Key" => "<key>"
  }
#parse the call  
payload2 = response.body				#sets the call response body as a variable
payload = payload2[/{.+}/]				#removes the callback prefix and suffix from the response body
data_hash = JSON.parse(payload)			#parses the response body and stores as a variable
#loop through parsed data to get the data you want
data_hash["data"]["20"].each do |ary|	#for each object in the array,
varSpd = ary["speed"]					#set var for "speed" value in array,
varCount = varCount + 1					#increase repeat iterations by 1,
varSum = varSum + ary["speed"]			#separately, set var for sum of all "speed" values in array,
end										#...end array loop
#write the data somewhere
varAvg = varSum / varCount				#calculate the average bus speed
somefile.puts varAvg.round(1)			#write the average bus speed to the .txt file
#log to console
b = b + 1								#represents the nth repeat iteration
puts b									#writes nth repeat iteration to console 

#CLEANUP
somefile.close							#closes .txt file
puts c									#writes "done" to console
sleep(10)								#waits 10 seconds before closing console
