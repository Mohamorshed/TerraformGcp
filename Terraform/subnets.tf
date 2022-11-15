resource "google_compute_network" "myvpc" {
  project                 = "mohamed-morshed"
  name                    = "myvpc"
  auto_create_subnetworks = false
 
}
resource "google_compute_subnetwork" "sub1" {
  name          = "management"
  
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-east1"
  project       = "mohamed-morshed"
  network       = google_compute_network.myvpc.name
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
  }
  resource "google_compute_subnetwork" "sub2" {
  name          = "restricted"
  ip_cidr_range = "10.3.0.0/16"
  region        = "us-east1"
  project       = "mohamed-morshed"
  network       = google_compute_network.myvpc.name
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update2"
    ip_cidr_range = "192.168.20.0/24"
  }
}