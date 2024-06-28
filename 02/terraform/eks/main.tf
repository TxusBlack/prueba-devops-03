module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-cluster-01"
  cluster_version = "1.30"

  vpc_id         = module.networking.vpc_id
  private_subnets = module.networking.private_subnets

  node_groups = {
    workers = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3a.medium"
    }
  }

  tags = {
    Name = "eks-cluster-01"
  }
}
