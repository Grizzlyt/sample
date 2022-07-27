variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  default = [
    "eu-west-2a",
    "eu-west-2b",
    "eu-west-2с"
  ]
}
variable "environment" {
  default = "development"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "public_subnets" {
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]
}

variable "database_subnets" {
  default = [
    "10.0.21.0/24",
    "10.0.22.0/24",
    "10.0.23.0/24"
  ]
}

variable "elasticache_subnets" {
  default = [
    "10.0.31.0/24",
    "10.0.32.0/24",
    "10.0.33.0/24"
  ]
}

variable "redis_cluster_size" {
  default = 1
}

variable "redis_instance_type" {
  default = "cache.t2.micro"
}

variable "redis_engine_version" {
  default = "6.x"
}

variable "redis_family" {
  default = "redis6.x"
}
