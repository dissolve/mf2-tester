// The test-one-go tool parses the provided HTML file and print the microformats found.
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/url"
	"os"

	"willnorris.com/go/microformats"
)

func main() {
	f, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer f.Close()

	baseURL, _ := url.Parse("http://example.com/")
	data := microformats.Parse(f, baseURL)

	json, _ := json.MarshalIndent(data, "", "  ")

	// unescape apostophes that golang.org/x/net/html insists on escpaing
	json = bytes.Replace(json, []byte(`\u0026#39;`), []byte(`'`), -1)
	// golang.org/x/net/html doesn't put a space at the end of self-closing
	// tags, but at least one test case expects it.
	json = bytes.Replace(json, []byte(`"/>`), []byte(`" />`), -1)

	fmt.Println(string(json))
}
