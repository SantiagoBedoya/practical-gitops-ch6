package main

import (
	"encoding/json"
	"log"
	"net/http"
)

type Message struct {
	Text string `json:"text"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	response := Message{Text: "Hello, World"}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func main() {
	http.HandleFunc("/", handler)
	log.Println("server listening at http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
