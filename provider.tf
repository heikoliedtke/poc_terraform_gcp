// Configure the Google Cloud provider

variable "credentials" {}
variable "project" {}
variable "region" {}
variable "startup_script" {}
 





provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
