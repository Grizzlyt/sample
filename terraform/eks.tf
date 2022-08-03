module "eks_cluster" {
  source  = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.6.1"

  # EKS CLUSTER
  cluster_version           = "1.22"
  cluster_name              = "eks-cluster"
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnets
  # EKS MANAGED NODE GROUPS
  managed_node_groups = {
    mg_m5 = {
      node_group_name = "sample-eks-cluster-nodes"
      instance_types  = ["m5.large"]
      subnet_ids      = module.vpc.private_subnets
    }
  }
}