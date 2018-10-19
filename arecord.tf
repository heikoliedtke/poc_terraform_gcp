
variable "aws_r53_domain" {}
variable "aws_r53_zone_id" {}

variable "aws_r53_subdomain" {

}


resource "aws_route53_record" "www" {
  zone_id = "${var.aws_r53_zone_id}"
  name    = "${var.aws_r53_subdomain}.${var.aws_r53_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${google_compute_global_address.default.address}"]
}


output "My_Website_URL" {
  value = "${aws_route53_record.www.fqdn}"
  
}