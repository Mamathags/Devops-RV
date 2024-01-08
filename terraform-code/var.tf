#=======================
#VPC Variables
#=======================
variable "aws_region" {
  #default = "eu-north-1"
  default = "ap-south-1"
  # default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "12.0.0.0/16"
}

variable "instance_tenancy" {
  default = "default"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_classiclink" {
  default = "false"
}

variable "vpc" {
  default = "aws_vpc.vpc.id"
}

variable "public_subnets_cidr" {
  default = ["12.0.1.0/24", "12.0.2.0/24"]
}
variable "private_subnets_cidr" {
  default = ["12.0.4.0/24", "12.0.5.0/24"]
}
variable "map_public_ip_on_launch" {
  default = "true"
}

variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b"]
}

# #================================
# #Existing EC2's
# #================================

# variable "ec_2_name" {
#   default = ["abc1", "abc2"]
# }

# variable "instance_type_ec_2" {
#   default = ["t2.micro","t3.micro"]
# }


#=======================
#EC2 Variables
#=======================
variable "amis" {
  #default = "ami-089c01c9d916066ce"
  # default = "ami-03b755af568109dc3"
  default = "ami-0a7cf821b91bcccbc"
  # us-east-2 default = "ami-0ff39345bd62c82a5"
}

variable "device_name" {
  default = "/dev/sdh"
}

variable "bastion_host_name" {
  default = "rv-bastionhost-ubuntu"
}
# variable "key" {
#   default = ""
# }
variable "key_name" {
  default = "rv_Pvtkey"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_data" {
  description = "User data script to install kubectl, eksctl, and awscli"
  type        = string
  default     = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    
    # Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x kubectl
    mv kubectl /usr/local/bin/
    
    # Install eksctl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    mv /tmp/eksctl /usr/local/bin/
    
    # Install awscli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
  EOT
}





#=======================
#ECR Variables
#=======================

variable "upstream_registry_url" {
  default = "public.ecr.aws"
}

variable "image_tag" {
  default = "MUTABLE"
}

variable "scan_onpush" {
  default = "true"
}

variable "ecr_repository_prefix" {
  default = "ecr-private"
}

# variable "tags" {
#   description = "A map of tags to assign to the resource rv-staging"
#   type        = map(string)
#   default     = {}
# }

variable "ECR_repo_name" {      
  type = list(string)
  default = [
    "sample"
    ]
}

variable "env" {
  default = "rv"
}




#EKS cluster Variables
#=======================

variable "eks_cluster_name" {
  default = "rv-clusterr"
}

variable "eks_nodegroup_name" {
  default = "rv-node-group"
}

/* variable "version" {
  default = "1.24"

} */

variable "endpoint_public_access" {
  default = true
  type = bool
}

variable "endpoint_private_access" {
  default = false
  type = bool
}

variable "capacity_type_1" {
  default = "ON_DEMAND"

}

variable "capacity_type_2" {
  default = "ON_DEMAND"
}

variable "capacity_type_3" {
  default = "ON_DEMAND"
}

variable "instance_types_1" {
  default = ["t2.medium"]
}

variable "instance_types_2" {
  default = ["t2.medium"]
}

variable "instance_types_3" {
  default = ["t2.medium"]
}


variable "disk_size" {
  default = "100"

}



variable "eks_ec2_data" {
  description = "User data script to install kubectl, eksctl, and awscli"
  type        = string
  default     = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    
    # Install kubectl
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x kubectl
    mv kubectl /usr/local/bin/
    
    # Install eksctl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    mv /tmp/eksctl /usr/local/bin/
    
    # Install awscli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
  EOT
}




