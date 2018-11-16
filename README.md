# Summary

The objective of project is to demonstrate the capabilities of Terraform in a small PoC. Terraform is used
to create several resources on Google Cloud Plattform in order to host a dummy webpage behind a loadbalancer.
In order to make the PoC more user friendly, the external IP of the loadbalancer is used to create a customized
URL on AWS. AWS has been chosen for convenience, because the author has a domain already registerd at AWS Route 53. This makes the PoC "multicloud"



# Solution

## Pre-Requisites

* Local installation of [terraform](https://www.terraform.io/intro/index.html)
* Create a GCP project for use with terraform according to this [GCP tutorial](https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform)
* Create a GCP service account with suitable roles and permissions and store the credentials.json file local


## Directory Structure

The terraform project is structured in the following folder hierarchy

 |---- Main

      |---- gcp_service_account_credentials.json

      |---- terraform.tfvars

      |---- poc_terraform_gcp

            |---- arecord.tf

            |---- aws_provider.tf

            |---- compute_instance_template.tf

            |---- networks.tf

            |---- provider.tf



The files <gcp_service_account_credentials.json> and <terraform.tfvars> are not part of this repository and
need to be created in the parent directory of the project.

## terraform.tfvars

The following variables are used in the project and need to be referenced in the terraform.tfvars file:


- *credentials* = <path to the file <gcp_service_account_credentials.json>
- *project* = GCP project
- *region* GCP region
- *public_key_path* = SSH public key
- *private_key_path* = SSH private key
- *startup_script* = Path to the startup script
- *aws_access_key* = AWS access key
- *aws_secret_key* = AWS secret key
- *aws_r53_domain* = <YOUR_DOMAIN>
- *aws_r53_zone_id* = Zone ID for the Domain, can be found on AWS R53 console

## IAM

This PoC project uses a startup script to "do some stuff" during the spin up of the instances. It is good practice to store the startup script on a GCP cloud storage bucket. In order to have access to the object in the bucket, please check IAM roles and permissions for your terraform service account user.
