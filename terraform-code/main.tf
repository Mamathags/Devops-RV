module "rv-vpc" {
  source               = "./module/VPC"
  vpc_cidr             = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink
}


module "Bastion-host" {
  source            = "./module/BastionHost"
  vpc_id            = module.rv-vpc.vpc_id
  key_name          = var.key_name
  ami               = var.amis
  instance_type     = var.instance_type
  subnet_public_1   = module.rv-vpc.subnet_public_1
  bastion_host_name = var.bastion_host_name
  device_name       = var.device_name
  ec2_data          = var.ec2_data
}

# module "ec-2" {
#   source             = "./module/EC2"
#   vpc_id             = module.rv-vpc.vpc_id
#   key_name           = var.key_name
#   ami                = var.amis
#   instance_type_ec_2 = var.instance_type_ec_2
#   subnet_public_1    = module.rv-vpc.subnet_public_1
#   ec_2_name          = var.ec_2_name
#   device_name        = var.device_name
#   ec2_data           = var.ec2_data
# }


module "ECR" {
  source                = "./module/ECR"
  ECR_repo_name         = var.ECR_repo_name
  upstream_registry_url = var.upstream_registry_url
  image_tag             = var.image_tag
  scan_onpush           = var.scan_onpush
  ecr_repository_prefix = var.ecr_repository_prefix
}


module "EKS_cluster" {
  source             = "./module/EKS"
  vpc_id             = module.rv-vpc.vpc_id
  eks_cluster_name   = var.eks_cluster_name
  subnet_public_1    = module.rv-vpc.subnet_public_1
  subnet_private_1   = module.rv-vpc.subnet_private_1
  subnet_private_2   = module.rv-vpc.subnet_private_2
  # subnet_private_3   = module.rv-vpc.subnet_private_3
  eks_nodegroup_name = var.eks_nodegroup_name
  /* version     =   var.version */
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  capacity_type_1         = var.capacity_type_1
  instance_types_1        = var.instance_types_1
  disk_size               = var.disk_size
  capacity_type_2         = var.capacity_type_2
  instance_types_2        = var.instance_types_2
  capacity_type_3        = var.capacity_type_3
  instance_types_3       = var.instance_types_3

}

