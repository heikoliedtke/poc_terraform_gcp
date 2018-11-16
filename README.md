# Summary

The objective of project is to demonstrate the capabilities of Terraform in a small PoC. Terraform is used
to create several resources on Google Cloud Plattform in order to host a dummy webpage behind a loadbalancer.
In order to make the PoC more user friendly, the external IP of the loadbalancer is used to create a customized
URL on AWS. AWS has been chosen for convenience, because the author has a domain already registerd at AWS Route 53. This makes the PoC "multicloud"



# Solution

## Pre-Requisites

* Local installation of [terraform](https://www.terraform.io/intro/index.html)
* Create a GCP project for use with terraform according to this [GCP tutorial](https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform)


## Directory Structure

The terraform project is structured in the following folder hierarchy

