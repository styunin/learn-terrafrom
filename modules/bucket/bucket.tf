# generate random_id
resource "random_id" "suffix" {
  byte_length = 5
}

# Create bucket 
resource "google_storage_bucket" "ttt-bucket" {
  name     = "ttt-bucket-${var.region}-${random_id.suffix.hex}"
  location = var.region
}
