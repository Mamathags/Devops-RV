
variable "instance_tenancy" {
}

variable "enable_dns_support" {
}

variable "enable_dns_hostnames" {
}

variable "enable_classiclink" {
}


variable "availability_zones" {
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = ""
}
variable "private_subnets_cidr" {
  default = ""
}
variable "public_subnets_cidr" {
  default = ""
}
variable "name" {
  default = "rv-security"
}
variable "environment" {
  default = "rv"
}
