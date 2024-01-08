variable "aws_region" {
  default = "ap-south-1"
}

variable "key_name" {
  default = ""
}

/* variable "path_to_public_key" {
  default = "getone.pub"
} */

variable "rds-sg-id" {
  default = ""
}

variable "ami" {
  default = ""
}

variable "instance_type" {
  default = ""
}
variable "key" {
  default = ""
}

variable "subnet_public_1" {
  type    = string
  default = ""
}
variable "subnet_private_1" {
  type    = string
  default = ""
}
variable "subnet_private_2" {
  default = ""
}
# variable "subnet_private_3" {
#   default = ""
# }

variable "vpc_id" {
  default = ""
}
variable "bastion_host_name" {
  default = ""
}

/* variable "bastion_host_namewind" {
  default = ""
  # default = "getone-bastionhostwind"
}

variable "amiswind" {
  default = ""
  #default = "ami-03b755af568109dc3"
 # default = "ami-0fd303abd14827300" 
} */

variable "device_name" {

}

variable "instance_typewind" {
  default = ""
}

variable "ec2_data" {}
