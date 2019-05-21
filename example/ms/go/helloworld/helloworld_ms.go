package main

import (
  "flag"
  "fmt"
  "io/ioutil"
  "log"
  "net/http"
  "os"
  "path/filepath"
  "strings"
)

func loadGreeting() string {
  dp := os.Getenv("KO_DATA_PATH")
  file := filepath.Join(dp, "static_greet")
  bytes, err := ioutil.ReadFile(file)
  if err != nil {
    log.Fatalf("Error reading %q: %v", file, err)
  }
  return string(bytes)
}

func main() {
  hwPort := flag.Int("port", 8080, "Listening port numbers")
  flag.Parse()
  greetingPrefix := loadGreeting()

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    recipient := strings.Replace(r.URL.Path, "/", "", -1)
    fmt.Fprintf(w, "{\"%s hello\": \"%s\"}\n", greetingPrefix, recipient)
  })

  http.ListenAndServe(fmt.Sprintf(":%d", *hwPort), nil)
}
