require 'unirest'
require 'json'
#fname = "sample.txt"
fname = "R-Line #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"
somefile = File.open(fname, "w")

response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=call&routes=4000032",
  headers:{
    "X-Mashape-Key" => "<key>"
  }



somefile.puts response.body
somefile.close
