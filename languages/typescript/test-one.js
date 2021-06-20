const { mf2 } = require('microformats-parser')

var infile = process.argv[2];

if (infile === undefined) {
  console.log("Usage: " + process.argv[1] + " <inputfile>");
  process.exit(1);
}

var fs = require("fs");

fs.readFile(infile, "utf8", function (err, data) {
    if (err) throw err;

    const parsed = mf2(data, {
        baseUrl: "http://example.com/",
    });
    console.log("%j", parsed);
});

