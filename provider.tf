// Configure the Google Cloud provider

variable "credentials" {}
variable "project" {}
variable "region" {}
variable "public_key_path" {}
variable "private_key_path" {}
variable "startup_script" {}
 





provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
