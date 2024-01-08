variable "eks_cluster_name" {
  default = ""
}
variable "eks_nodegroup_name" {
  default = ""
}
variable "private_subnets_cidr" {
  default = ""
}
variable "public_subnets_cidr" {
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

variable "subnet_public_1" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

/* 
variable "version" {
   default = ""
  
} */




variable "endpoint_public_access" {
  /* default = "" */
  type = bool
}

variable "endpoint_private_access" {
  /* default = "" */
  type = bool
}

variable "capacity_type_1" {
  default = ""
}

variable "capacity_type_2" {
default = ""
}

variable "capacity_type_3" {
default = ""
}

variable "instance_types_1" {
 default = ""
}

variable "instance_types_2" {
 default = ""
 }

 variable "instance_types_3" {
 default = ""
 }

variable "disk_size" {
 default = ""

}