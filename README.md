A collection of Ruby scripts that query the TransLoc API and log relevant data points as CSV data.

LAST UPDATED: 11/24/14

DISCLOSURE: I'm self-taught in scripting.  This is my first time using Ruby, or pretty much any 
language.  The script works, but I'm not always sure why.  FWIW

SETTING UP RUBY:
*	You will need to install a copy of Ruby (https://www.ruby-lang.org/en/)  I'm running version
	2.0.0-p594-x64 on Windows 7 and having no issues.  
* 	You'll need to install 2 gems: unirest and json.  Google is your friend.  

ACCESSING THE API:
*	You will need to get a key from (www.mashape.com) to get returns from the TransLoc API. An
	account at Mashape is free and getting a key is relatively easy.  

BEFORE YOU RUN ANY OF THE SCRIPTS:
*	Paste your mashape key into each script in the line which begins "X-Mashape-Key". The result 
	will be a line of code that looks something like this (including parens): 
	"X-Mashape-Key" => "abc123DEF456..."
*	Update the Unirest.get statement to reflect the agencies you wish to query.  By default, the
	scripts query agencies 12, 16 and 20. 
	
BEFORE YOU RUN VehicleSpeed_API_Analysis.rb:
* 	Update the script to reflect the transit agencies (&agencies=) you wish to query. Specifically,
	you will want to change the 2nd bracketed number value in each of the 3 commented sections where 
	the line begins with:	data_hash["data"]["20"].each do |ary| 
	["20"] represents the agency_id value. 
*	The script queries the API every 30 seconds for 10,000 cycles.  These variables can be changed
	and are represented as variables "d" and "varNum" respectively in the script.  
* 	Be aware that the script is written to query 3 transit agencies. It will be easiest for you to 
	do the same, even if you are only interested in a single agency.  The way the script is coded
	with loops, it's not obvious how to extend or reduce the number of agencies queried.  
* 	The best way to launch VehicleSpeed_API_Analysis.rb is by using the included .bat file called
	BatFile_VehSpd_API_An.bat (if you are using windows).  I'm having issues with the script 
	crashing when the Unirest.get statement returns nothing.  This usually happens at night, when 
	you would expect a null response (because most agencies don't run their fleet all throughout 
	the night) but occasionally it will return a null value during the daytime as well for unknown
	reasons.  This looping .bat file just re-launches the script when it closes or crashes.  

WHAT THE SCRIPTS DO: 
*	BatFile_VehSpd_API_An.bat - a windows batch file that launches VehicleSpeed_API_Analysis.rb and
	re-starts the script after it finishes or if it crashes due to a null response. 
* 	VehicleSpeed_API_Analysis.rb queries the API every 30 seconds, parses the response, 
	and outputs the data to "AgencySpeed_bus {datestamp}.txt".  "AgencySpeed_log {datestamp}.txt" is
	a log file of each query cycle and is not usually useful.  "AgencySpeed_avg {datestamp}.txt" is 
	a log file that displays the average fleet speed for each agency queried for each cycle, and 
	may not be that useful.  
* 	VehicleSpeed_API_Analysis.rb also outputs 5 .txt files that cache data for use in a dashboard.  
* 	VehicleSpeed_API_Analysis.rb outputs "VehicleSpeedDash.html" that live-tracks some of the data
	in a dashboard format.  The html file refreshes automatically every 30 seconds and can be viewed
	live during the period of query or after it's completed.  
* 	VehicleSpeed_API_Full_Log.rb outputs "ResponseLog {datestamp}{timestamp}.txt" which contains the 
	un-parsed API call.  May be useful if you want to review the response from a single call. This
	script is not a necessary component of any of the other scripts. 

OTHER NOTES: 
*	I've not done a great job commenting the code to explain what is happening.  That will change. 
