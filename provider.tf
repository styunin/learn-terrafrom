#Configure GCP provider

provider "google" {
  project     = "playground-s-11-b8ed5eb4"
  credentials = file("key.json")
  region      = var.region # see variable.tf
  zone        = var.zone   # see variable.tf
}
