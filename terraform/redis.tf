module "elasticache-redis" {
  source  = "cloudposse/elasticache-redis/aws"
  version = "0.44.0"
  name                       = "sampe"
  availability_zones         = var.availability_zones
  zone_id                    = element(var.availability_zones, 0)
  vpc_id                     = module.vpc.vpc_id
  allowed_security_group_ids = [module.security-groups-redis.security_group_id]
  subnets                    = module.vpc.elasticache_subnets
  cluster_size               = var.redis_cluster_size
  instance_type              = var.redis_instance_type
  apply_immediately          = true
  automatic_failover_enabled = false
  engine_version             = var.redis_engine_version
  family                     = var.redis_family
  kms_key_id                 = module.kms.key_arn
  at_rest_encryption_enabled = "true"
  transit_encryption_enabled = "true"
  replication_group_id       = "sample"

}