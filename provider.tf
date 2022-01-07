#Configure GCP provider

provider "google" {
  project     = var.project
  credentials = file("key.json")
  region      = var.region # see variable.tf
  zone        = var.zone   # see variable.tf
}
