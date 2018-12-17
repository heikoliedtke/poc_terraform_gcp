// Configure the Google Cloud provider

variable "credentials" {}
variable "project" {}
variable "region" {}
variable "startup_script" {}
variable "mysql_root_password" {}
variable "mysql_database" {}
variable "mysql_user" {}
variable "mysql_password" {}

 





provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
