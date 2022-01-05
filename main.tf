#Configure GCP provider

provider "google" {
  project     = "playground-s-11-935db860"
  credentials = file("CREDENTIALS_FILE2.json")
  region      = "us-central1"
  zone        = "us-central1-c"
}


# Create VPC

resource "google_compute_network" "vpc_network" {
  project                 = "playground-s-11-935db860"
  name                    = "ttt-vpc"
  auto_create_subnetworks = true
}

# Create vm instancce

resource "google_compute_instance" "default" {
  name         = "ttt-vm"
  machine_type = "f1-micro"
  zone         = "us-central1-c"

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
