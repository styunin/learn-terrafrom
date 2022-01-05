provider "google" {
  project     = "<your project-id>" 
  credentials = file("<key>.json")
  region      = "europe-west1"
  zone        = "europe-west1-d"
}
