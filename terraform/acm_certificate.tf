resource "aws_acm_certificate" "sample" {
  domain_name       = var.eks_cluster_domain
  validation_method = "DNS"

  tags = {
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "sample" {
  certificate_arn         = aws_acm_certificate.sample.arn
  validation_record_fqdns = [for record in aws_route53_record.sample : record.fqdn]
}
