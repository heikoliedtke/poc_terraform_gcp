resource "google_compute_network" "custom-test" {
  name = "test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network-a" {
    name = "sub-a"
    ip_cidr_range = "10.0.33.0/24"
    region = "${var.region}"
    network = "${google_compute_network.custom-test.self_link}"
}
resource "google_compute_subnetwork" "network-b" {
    name = "sub-b"
    ip_cidr_range = "10.0.55.0/24"
    region = "${var.region}"
    network = "${google_compute_network.custom-test.self_link}"
}
resource "google_compute_firewall" "default"{
    name = "ssh-fire"
    network = "${google_compute_network.custom-test.name}"

    allow {
        protocol = "tcp"
        ports = ["22","80"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["web"]
}
