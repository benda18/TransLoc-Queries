# A script that does statistical analysis on an array


require 'descriptive_statistics'
# descriptive_statistics documentation here: https://rubygems.org/gems/descriptive_statistics
require 'csv'

puts "\e[H\e[2J"

#vars/defs
vSAfile = "VehicleSpeedArray.txt"

arr1 = []
varI = 1

list =CSV.foreach(vSAfile, :headers => true, :return_headers => false) do |row|
	varRtnam = row["route"]#.to_a
	#varI += 1
	if varRtnam == "4000042"
	#puts "#{varRtnam}, #{row[6]} --- #{varI}"
	arr1 << row[3].to_f
	end
end
#puts arr1

puts arr1.descriptive_statistics.to_a

