module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 12.2.0"  # old version

  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }

  enable_irsa = true
}
