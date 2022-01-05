provider "google" {
  project     = "playground-s-11-935db860" 
  credentials = file("CREDENTIALS_FILE2.json")
  region      = "europe-west1"
  zone        = "europe-west1-d"
}
