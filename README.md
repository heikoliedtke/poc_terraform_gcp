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
- *startup_script* = Path to the startup script. e.g. Cloud Storage Bucket
- *aws_access_key* = AWS access key
- *aws_secret_key* = AWS secret key
- *aws_r53_domain* = <YOUR_DOMAIN>
- *aws_r53_zone_id* = Zone ID for the Domain, can be found on AWS R53 console

## IAM

This PoC project uses a startup script to "do some stuff" during the spin up of the instances. It is good practice to store the startup script on a GCP cloud storage bucket. In order to have access to the object in the bucket, please check IAM roles and permissions for your terraform service account user.

## Walkthrough

Terraform will consider all files in a directory with the ending *.tf as part of the stack. The name and order
of the files doesnt care, terraform will check the whole config stack for dependencies.

`terraform plan -var-file=../terraform.tfvars`

This command will start a terraform dry run, where all found *.tf files are interpreted. The output will tell what resoruces will be created.

`terraform run -var-file=--/terraform.tfvars`

This command will start the deployment.
NOTE: Because the variable "aws_r53_subdomain" is not set in the tfvars file, terraform will prompt for a value
prior execution.

The following resources will be created

- VPC "custom-test" in custom mode
- Subnetwork "sub-a" with IP range 10.0.33.0/24
- Subnetwork "sub-b" with IP range 10.0.55.0/24

- Firewall rule "ssh-fire" wich allows SSH and HTTP traffic from 0.0.0.0/ to all
targets with a tag "web"

- GCP Compute Instance template "webserver" with Debian 9 
- GCP Compute Instance Group Manager "my-webservers" with a target size of 2 instances
- GCP Compute HTTP Health check "test"
- GCP Compute Backend Service "my-backend"
- GCP Global IP Address "frontendip"
- GCP Global Compute Forwarding Rule "default-rule"
- GCP Compute URL map "url-map"
- AWS Route 53 Record


If everything is created successfully, terraform will provide the FQDN, the Full URL, of the
new deployment. An AWS R53 A record, which is pointing to a GCP global frontend IP. How cool is this.


## Cleanup

`terraform destroy -var-file=--/terraform.tfvars`



