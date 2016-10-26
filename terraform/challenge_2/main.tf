provider "google" {
  project = "api-project-939426582926"
  region = "us-central1"
  credentials = "${file("../google.json")}"
}



resource "google_compute_instance" "test1" {
  name = "test1"
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

resource "google_compute_instance" "test2" {
  name = "test2"
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


 resource "google_compute_instance_group" "challenge" {
  name        = "terraform-challenge"
  description = "Terraform  challenge Group"

  instances = [
    "${google_compute_instance.test1.self_link}",
    "${google_compute_instance.test2.self_link}"
  ]

  zone = "us-central1-a"
 }

