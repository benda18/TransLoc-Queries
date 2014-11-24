#A scipt that logs the json api data in it's entirety  and writes it to a file one time. 

require 'unirest'
require 'json'
#fname = "sample.txt"
fname = "ResponseLog #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"
somefile = File.open(fname, "w")

#<call the transloc api>
response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=12%2C16%2C20&callback=call",
  headers:{
    "X-Mashape-Key" => "<key>"
  }

somefile.puts response.body
somefile.close
