

resource "google_service_account" "sv" {
  account_id   = "service-account-myid"
  display_name = "Service"
}






resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  project = "mohamed-morshed"
  location= "us-east1-b"
  remove_default_node_pool = true
  initial_node_count       = 1
  network=google_compute_network.myvpc.id
  subnetwork=google_compute_subnetwork.sub2.id
 
master_authorized_networks_config {
 cidr_blocks {
  cidr_block = google_compute_subnetwork.sub1.ip_cidr_range
      display_name = "net1"
    }



}








  private_cluster_config {
    enable_private_nodes    = true       #Enables the private cluster feature, creating a private endpoint on the cluster
    enable_private_endpoint = true       #disable public access to endpoint and access to cluster 
    master_ipv4_cidr_block  = "10.5.0.0/28"
    
  } 
  
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-east1-b"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.sv.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }





  
}



resource "google_compute_firewall" "rules" {
  project     = "mohamed-morshed"
  name        = "my-firewall-rule"
  network     = google_compute_network.myvpc.name
  description = "Creates firewall rule targeting  instances of gke"
  direction   = "EGRESS"
  source_ranges= [google_compute_subnetwork.sub2.ip_cidr_range]

  deny {
    protocol  = "tcp"
    ports     = ["80","443"]
  }

}
resource "google_compute_firewall" "rules2" {
  project     = "mohamed-morshed"
  name        = "my-firewall-rule2"
  network     = google_compute_network.myvpc.name
  description = "Creates firewall rule targeting  instances of input for gke"
  direction   = "INGRESS"
  source_ranges= [google_compute_subnetwork.sub1.ip_cidr_range]

  allow {
    protocol  = "tcp"
    ports     = ["22","80","443","81","82"]
  }

}
resource "google_compute_firewall" "rules3" {
  project     = "mohamed-morshed"
  name        = "my-firewall-rule3"
  network     = google_compute_network.myvpc.name
  description = "Creates firewall rule targeting  instances of input for gke"
  direction   = "INGRESS"
  source_ranges= ["35.235.240.0/20"]

  allow {
    protocol  = "tcp"
    ports     = ["22","80","443"]
  }

}


















































