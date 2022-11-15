resource "google_compute_instance" "web_private_1" {
  name = "privitevm"
  project = "mohamed-morshed"
  machine_type = "e2-micro"
  zone = "us-east1-b"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
   
  network_interface {
    network = google_compute_network.myvpc.name
    subnetwork = google_compute_subnetwork.sub1.name
  }
}