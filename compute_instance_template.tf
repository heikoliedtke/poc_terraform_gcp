resource "google_compute_instance_template" "webserver" {
  name         = "webserver"
  machine_type = "n1-standard-1"
  
  tags = ["web" , "http-server", "https-server"]
  
  disk {
      source_image = "debian-cloud/debian-9"
      boot = true
      auto_delete = true
    }

  network_interface {
    subnetwork = "${google_compute_subnetwork.network-a.self_link}"
    access_config {
      //ephemeral
    }
  }

  metadata {
    startup-script-url = "${var.startup_script}"
    ssh-keys = "heikoliedtke:${file("${var.public_key_path}")}"
  }

  service_account {
    email = "terraform@terraform-217317.iam.gserviceaccount.com"
    scopes = ["storage-ro", "compute-rw"]
  }
  }
resource "google_compute_instance_group_manager" "webservers" {
  name               = "my-webservers"
  instance_template  = "${google_compute_instance_template.webserver.self_link}"
  base_instance_name = "webserver"
  zone               = "europe-west3-a"
  target_size        = 2
}
resource "google_compute_http_health_check" "default" {
  name               = "test"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}
resource "google_compute_backend_service" "website" {
  name        = "my-backend"
  description = "Our company website"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = "${google_compute_instance_group_manager.webservers.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.default.self_link}"]
}

//+++++++++++++++++++++++++++++++++++++++++++++

resource "google_compute_global_address" "default" {
  
  name       = "frontendip"
}


resource "google_compute_global_forwarding_rule" "default" {
  name       = "default-rule"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80"
  ip_address = "${google_compute_global_address.default.address}"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "test-proxy"
  description = "a description"
  url_map     = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  description     = "a description"
  default_service = "${google_compute_backend_service.website.self_link}"

  host_rule {
    hosts = ["mysite.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.website.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.website.self_link}"
    }
  }
}




//+++++++++++++++++++++++++++++++++++++++++++++






/*
output "gcp_backend_self_link" {
  value = "${google_compute_global_address.default.address}"
test!!!!

}*/