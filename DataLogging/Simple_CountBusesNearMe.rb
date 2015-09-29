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
#puts "\e[H\e[2J"
#
#--VARIABLES--
fileBus = "BusesNearMe.html"
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
    "X-Mashape-Key" => "JvUSwjy4vVmshjFC0u1soQ4cUen8p1zDEzfjsndmsnZomPfbX1"
  }
payload2 = response.body
payload = payload2[/{.+}/]
data_hash = JSON.parse(payload)
varVct = 0
Array(data_hash["data"]["20"]).each do |block|
varVct += 1
end
File.open(fileBus, "w+") do |fb1|										#starts hbname over as a blank file each launch. 
fb1.puts "<html>"
fb1.puts "<body>"
fb1.puts "#{"<META HTTP-EQUIV="}#{'"'}#{"refresh"}#{'"'}#{" CONTENT="}#{'"'}#{30}#{'"'}#{">"}"#refresh code
fb1.puts "<font size=#{'"'}30#{'"'} color=#{'"'}red#{'"'}><b>#{varVct}</b></font><br>"
fb1.puts "buses within 1/4 mile"
fb1.puts "</body>"
fb1.puts "</html>"
end
#puts "#{varVct} buses within 1/4 mile of me right now"
#  
