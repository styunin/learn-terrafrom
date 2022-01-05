#Configure GCP provider

provider "google" {
  project     = "<your project-id>" 
  credentials = file("<key>.json")
  region      = var.region          # see variable.tf
  zone        = "europe-west1-d"
}
