package main

import (
  "flag"
  "fmt"
  "net/http"
  "strings"
)

func main() {
  hwPort := flag.Int("port", 8080, "Listening port numbers")
  flag.Parse()

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    recipient := strings.Replace(r.URL.Path, "/", "", -1)
    fmt.Fprintf(w, "{\"hello\": \"%s\"}", recipient)
  })

  http.ListenAndServe(fmt.Sprintf(":%d", *hwPort), nil)
}
