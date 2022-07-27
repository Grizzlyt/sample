locals {
  name             = "kms-sample-app-key"
  current_identity = data.aws_caller_identity.current.arn

  tags = {
    Name       = local.name
  }
}

data "aws_caller_identity" "current" {}

################################################################################
# KMS Module
################################################################################

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.0.2"

  deletion_window_in_days = 7
  description             = "KMS KEY"
  enable_key_rotation     = false
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  multi_region            = false

  # Policy
  enable_default_policy                  = true
  key_owners                             = [local.current_identity]
  key_administrators                     = [local.current_identity]
  key_users                              = [local.current_identity]
  key_service_users                      = [local.current_identity]
  key_symmetric_encryption_users         = [local.current_identity]
  key_hmac_users                         = [local.current_identity]
  key_asymmetric_public_encryption_users = [local.current_identity]
  key_asymmetric_sign_verify_users       = [local.current_identity]

  # Aliases
  aliases                 = ["sample_app"]
  aliases_use_name_prefix = true

  # Grants
  grants = {
    lambda = {
      grantee_principal = aws_iam_role.all.arn
      operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_iam_role" "all" {
  name_prefix = local.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "*"
        }
      }
    ]
  })
}