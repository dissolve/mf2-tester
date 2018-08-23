var Microformats = require('microformat-node')

var infile = process.argv[2];

if (infile === undefined) {
  console.log("Usage: " + process.argv[1] + " <inputfile>");
  process.exit(1);
}

var fs = require("fs");

fs.readFile(infile, "utf8", function (err, data) {
    if (err) throw err;
     var Microformats = require('microformat-node'),
        options = {};

    options.html = data
    options.baseUrl = 'http://example.com/'
    Microformats.get(options, function(err, outdata){
        console.log("%j", outdata)
        // do something with data
    });
});

