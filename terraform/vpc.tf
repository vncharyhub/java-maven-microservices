data "aws_availability_zones" "azs" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = ">=3.0"
  name = var.cluster_name
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.azs.names[0:2]
  public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24","10.0.4.0/24"]
}
