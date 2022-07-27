module "security-groups-redis" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"
  name        = "user-service"
  description = "SG for Elasticache Rediss"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = [var.cidr_block]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = module.elasticache-redis.port
      to_port     = module.elasticache-redis.port
      protocol    = "tcp"
      description = "Redis port"
      cidr_blocks = join(",", var.elasticache_subnets)
    }
  ]
}

module "security-group-rds" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"
  name        = "user-service"
  description = "SG for RDS"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = [var.cidr_block]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = module.rds.db_instance_port
      to_port     = module.rds.db_instance_port
      protocol    = "tcp"
      description = "RDS port"
      cidr_blocks = join(",", var.database_subnets)
    }
  ]
}