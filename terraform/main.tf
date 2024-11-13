locals {
  name         = "demo-service-types"
  cluster_name = format("%s-%s", local.name, "eks")

  default_tags = {
    stack       = local.name
    terraform   = true
    description = "Demonstrate the different types of services in Kubernetes"
  }
}

module "vpc" {
  count          = var.create_vpc ? 1 : 0
  source         = "./modules/vpc"
  stack_name     = local.name
  vpc_cidr_block = "10.1.0.0/16"

  list_of_azs        = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  list_of_cidr_range = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  default_tags = local.default_tags
  cluster_name = local.cluster_name
}

module "rds" {
  count          = var.create_rds ? 1 : 0
  source         = "./modules/rds"
  vpc_id         = module.vpc[0].vpc_id
  public_subnets = module.vpc[0].list_of_subnet_ids
  /*
  Hardcoded the password for convenience. Best practice would be to store the 
  password in AWS Secrets Manager or GitLab/GitHub variables, and then have
  the pipeline to refer to these sources for the password.
  */
  db_password    = "hfdsn768!" 
}