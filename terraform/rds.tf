module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.1"

  identifier = "sampleappdb"
  engine            = "mysql"
  engine_version    = "5.7.25"
  instance_class    = "db.t3a.small"
  allocated_storage = 5

  db_name  = "sampledbuser"
  port     = "3306"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = [module.security-group-rds.security_group_id]

  maintenance_window  = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = var.environment
  }

  # DB subnet group
  create_db_subnet_group = false
  subnet_ids             = module.vpc.database_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]

}