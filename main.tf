# Create VPC

resource "google_compute_network" "vpc_network" {
  project                 = "<your_project>"
  name                    = "ttt-vpc"
  auto_create_subnetworks = true
}

# Create storage bucket
resource "google_storage_bucket" "ttt-bucket" {
  name     = "ttt-bucket-07012022"
  location = "EUROPE-WEST4"
}

# Create vm instancce

resource "google_compute_instance" "default" {
  name         = "ttt-vm"
  machine_type = "f1-micro"
  zone         = "europe-west4-c"

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

# Get the IP of the vm

output "ip" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}
