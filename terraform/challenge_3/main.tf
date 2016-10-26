provider "google" {
  project = "api-project-939426582926"
  region = "us-central1"
  credentials = "${file("../google.json")}"
}

resource "google_compute_instance" "als-terraform-assignment3" {
	name = "als-terraform-assignment3"
	machine_type = "n1-standard-1"
  	zone         = "us-central1-a"
  	disk {
   	 image = "debian-cloud/debian-8"
  	}

  	disk {
	    type    = "local-ssd"
	    scratch = true
	}

  network_interface {
    network = "default"
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get upgrade"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }


} 