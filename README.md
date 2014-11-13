A collection of Ruby scripts that collect and convert TransLoc real-time transit 
information into local .txt files for further data analysis.  

DISCLOSURE: I'm self-taught in scripting.  This is my first time using Ruby, or 
pretty much any language.  The script works, but I'm not always sure why.  FWIW

"ConsoleCompareAgencySpeed.rb" is the only script that is being developed now. The
other scripts are old and contain errors.  Additionally, these other scripts were
individual elements that have been merged together into "ConsoleCompareAgencySpeed.rb"

If this repository for some reason only contains a single ruby script ("ConsoleCompareAgencySpeed")
that means that I've deleted the others.  

TO RUN THE SCRIPT:

1. you will need a <key> from mashape.com. Mashape hosts the TransLoc api; create an account there
  and insert your unique key in the .rb script where you see <key>.  
2. you'll need to install a copy of Ruby on your machine and ensure that you install the following gems:
  * unirest - installing this gave me problems.  google is your friend. 
  * json
3. copy the script to a local directory on your machine and double-click to run.  The console will open and 
  ask you to provide 2 inputs: 
  * 'How long to sleep (in seconds) between each loop? (typically ~5)' - this variable will represent the sleep() 
    delay between interative call loops (the begin / end until statement)
  * 'How many loops to perform? (typically ~10)' - this variable will represent how many times the script will loop 
    before it ends.  
4. The output of the script will be 3 .txt files in the same directory as the .rb file: 
  * "AgencySpeed_bus {timestamp}.txt" - a csv file that has one record for each unique bus queried and associated data
  * "AgencySpeed_avg {timestamp}.txt" - a csv file that shows calculated average fleet speed for each agency at each 
    point in time
  * "AgencySpeed_log {timestamp}.txt" - a txt file that simply logs what the console displays in case you want to review. 
5. Additionally the console will display you two variable inputs, keep track of how many loops have been completed, and
  display instant fleed average speed data by agency, as well as a calculated cumulative (or rolling average) fleet 
  speed for the duration of the script.  

FURTHER NOTES:

1. The script is written to call the TransLoc "Vehicles" api and query certain data on vehicle speed, location, 
  bearing, route and segment.  You can tweak this to call more or less data by referencing the api at Mashape. 
2. The script is writen to query only 2 agencies - Triangle Transit and Capital Area Transit in North Carolina.  
  The agency_id for these two are 12 and 20, respectively.  You may want to query different agencies.  If so, 
  you'll need to figure out the agency_ids for those - you can do this at mashape - and update the script
3. The script is written to query 2 and only 2 agencies. if you want to query only 1 agency you'll need to tweak 
  the script.  Same if you want to query 3 or more.  This is relatively straight-forward: 
  * for each agency there is 1 ".each do / end" loop statement just make sure the script has one of these loops
    for each agency, and update the code to ensure that the outputs are written to the associated .txt files.  
4. I've tried to comment the script as best as possible to keep track of what it's doing.  
