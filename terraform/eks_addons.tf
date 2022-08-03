module "eks_addons" {
  source                               = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.6.1"

  eks_cluster_id                       = module.eks_cluster.eks_cluster_id
  eks_cluster_endpoint                 = module.eks_cluster.eks_cluster_endpoint
  eks_oidc_provider                    = module.eks_cluster.oidc_provider
  eks_cluster_version                  = module.eks_cluster.eks_cluster_version
  eks_cluster_domain                   = var.eks_cluster_domain

  # EKS Addons
  enable_amazon_eks_vpc_cni            = true
  enable_amazon_eks_coredns            = true
  enable_amazon_eks_kube_proxy         = true
  enable_amazon_eks_aws_ebs_csi_driver = true

  #K8s Add-ons
  enable_argocd                       = true
  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
  enable_metrics_server               = true
  enable_prometheus                   = true
  enable_ingress_nginx                = true
  ingress_nginx_helm_config = {
    values = [templatefile("${path.module}/nginx-values.yaml", {
      hostname     = var.eks_cluster_domain
      ssl_cert_arn = aws_acm_certificate.sample.arn
    })]
  }
  enable_external_dns                 = true
}