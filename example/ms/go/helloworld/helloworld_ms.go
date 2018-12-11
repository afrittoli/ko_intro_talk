package main

import (
  "flag"
  "fmt"
  "net/http"
)

func main() {
  hwPort := flag.Int("port", 8080, "Listening port numbers")
  flag.Parse()

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "{\"hello\": \"%s\"}", r.URL.Path)
  })

  http.ListenAndServe(fmt.Sprintf(":%d", *hwPort), nil)
}
