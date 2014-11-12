require 'unirest'
require 'json'
#fname = "sample.txt"
fname = "CAT #{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"
somefile = File.open(fname, "w")

response = Unirest.get "https://transloc-api-1-2.p.mashape.com/vehicles.jsonp?agencies=20&callback=call",
  headers:{
    "X-Mashape-Key" => "5SA6zZbMxpmshjhL0Y8ERCZ2WqnIp1zgKOmjsnXy5WDKmZaGC4"
  }



somefile.puts response.body
somefile.close