# generate random_id
resource "random_id" "suffix" {
  byte_length = 5
}


# Create VPC

resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "ttt-vpc"
  auto_create_subnetworks = false # to create custom subnet
}

# Create custom subnet

resource "google_compute_subnetwork" "network-with-custom_subnet" {
  name          = "ttt-subnet-01"
  ip_cidr_range = "192.168.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}


# Create firewall rules

resource "google_compute_firewall" "rules" {
  project = var.project
  name    = "web-firewall-rule"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "22"] # allow ssh + http

  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]

}

# Create storage bucket
module "bucket" {
    source = "./modules/bucket"
    region = var.region

# Create vm instancce

resource "google_compute_instance" "ttt-vm" {
  count        = 3
  name         = "ttt-vm-${count.index + 1}"
  machine_type = "f1-micro"
  zone         = var.zone

  metadata_startup_script = <<EOF
  sudo apt-get update 
  sudo apt-get install -y nginx 
  sudo systemctl enable nginx 
  sudo systemctl start nginx 
  echo '<!doctype html><html><body><h1>Hello from Terraform on GCP!</h1></body></html>' > /var/www/html/index.nginx-debian.html
  EOF

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link # linking vpc to the VM's network
    subnetwork = google_compute_subnetwork.network-with-custom_subnet.self_link
    access_config {
    }
  }
  tags = ["web"]

}

# show VM's IP

output "ip" {
  value = [google_compute_instance.ttt-vm.*.network_interface.0.network_ip]
}
