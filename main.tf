resource "google_service_account" "default" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = [var.tags]

  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = var.network

    access_config {
      // Ephemeral public IP
    }
  }




  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}