# A script that shows how many buses are within a given radius
# of the user at that particular moment in time. 
#
#--PROCESS--
#
#-----------------------------
# 1. Get my ip address
#-----------------------------
# 2. Get my location (lon/lat)
#-----------------------------
# 3. Calculate boundary radius around my location
#-----------------------------
# 4. Query vehicles within a radis (x) of my location
#-----------------------------
# 5. Count the # of vehicles and display
#-----------------------------
#
#--REQUIRE-STATEMENTS--
require 'unirest'
require 'json'
require 'socket'
puts "\e[H\e[2J"
#
#--VARIABLES--
#
#--MY-IP-ADDRESS--
#
#--MY-LOCATION--
varGI = "35.777531%2C-78.637277%7C400"
#
#--VEHICLE-QUERY--
response = 0
varURL = "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=GET&geo_area=#{varGI}"
# These code snippets use an open-source library. http://unirest.io/ruby
response = Unirest.get varURL,
  headers:{
    "X-Mashape-Key" => "<key>"
  }
payload2 = response.body
payload = payload2[/{.+}/]
data_hash = JSON.parse(payload)
varVct = 0
Array(data_hash["data"]["20"]).each do |block|
varVct += 1
end
puts "#{varVct} buses within 1/4 mile of me right now"
#  
