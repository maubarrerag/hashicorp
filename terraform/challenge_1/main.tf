
//provider "aws" {
 // access_key = "${var.access_key}"
 // secret_key = "${var.secret_key}"
 // region     = "${var.region}"
//}

provider "google" {
  project = "api-project-939426582926"
  region = "us-central1"
  credentials = "${file("google.json")}"
}


resource "google_compute_instance" "challenge_1" {
   name = "test"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  tags = ["foo", "bar"]
  disk {
    image = "debian-cloud/debian-8"
  }
  disk {
    type    = "local-ssd"
    scratch = true
  }

  network_interface {
    network = "default"
    access_config {
       //Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get upgrade"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
 }
