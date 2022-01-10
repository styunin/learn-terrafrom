# generate random_id
resource "random_id" "suffix" {
  byte_length = 5
}


# Create VPC

resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "ttt-vpc"
  auto_create_subnetworks = true
}

# Create storage bucket
resource "google_storage_bucket" "ttt-bucket" {
  name     = "ttt-bucket-20220110-${random_id.suffix.hex}"
  location = var.region
}

# Create vm instancce

resource "google_compute_instance" "default" {
  count        = 3
  name         = "ttt-vm-${count.index + 1}"
  machine_type = "f1-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }
}

