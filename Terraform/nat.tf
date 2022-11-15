






resource "google_compute_router" "router" {
  name    = "my-router"
  project = "mohamed-morshed"
  region  = "us-east1"
  network = google_compute_network.myvpc.name
}



resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  project                            = "mohamed-morshed"
  router                             = google_compute_router.router.name
  region                             = "us-east1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {                         
  
  name                               = google_compute_subnetwork.sub1.name
  source_ip_ranges_to_nat            = ["ALL_IP_RANGES"]
  
} 

  }



