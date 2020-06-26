package main

import (
	"bytes"
	"bufio"
	"net/http"
	"net/url"
	"mime/multipart"
	"io"
	"io/ioutil"
	"os"
	"fmt"
	"strings"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println(
			"usage:",
			os.Args[0],
			"<input-file> [options] <output-file>",
		)

		os.Exit(-1)
	}

	var serviceUrl = os.Getenv("CONVERTER_URL")
	var input = os.Args[1]
	var output = os.Args[len(os.Args) - 1]
	var options = os.Args[2:len(os.Args) - 1]
	var optionsParam = strings.Join(options[:], " ")

	var b bytes.Buffer
	w := multipart.NewWriter(&b)

	var fw io.Writer
	fw, err := w.CreateFormFile("image", input)
	if err != nil {
		panic(err)
	}

	inputFile, err := os.Open(input)
	if err != nil {
		panic(err)
	}

	if _, err := io.Copy(fw, bufio.NewReader(inputFile)); err != nil {
		panic(err)
	}

	optionsEncoded := strings.Replace(url.QueryEscape(optionsParam), "+", "%20", -1)
	if err := w.WriteField("options", optionsEncoded); err != nil {
		panic(err)
	}

	w.Close()

	client := &http.Client{}
	req, err := http.NewRequest("POST", serviceUrl, &b)
	if err != nil {
		panic(err)
	}

	req.Header.Set("Content-Type", w.FormDataContentType())

	res, err := client.Do(req)
	if err != nil {
		panic(err)
	}

	if res.StatusCode == 200 {
		f, err := os.Create(output)
		if err != nil {
			panic(err)
		}

		body, err := ioutil.ReadAll(res.Body)
		if err != nil {
			panic(err)
		}

		f.Write(body)
		f.Close()
	} else if res.StatusCode == 400 {
		body, err := ioutil.ReadAll(res.Body)
		if err != nil {
			panic(err)
		}

		fmt.Println(string(body))
	}
}
