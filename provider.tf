// Configure the Google Cloud provider

variable "credentials" {}
variable "project" {}
variable "region" {}
variable "startup_script" {}
variable "git_user" {}
variable "git_pwd" {}


 





provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
