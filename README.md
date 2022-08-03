### Sample project
# Introduction

The code in the repository deploy AWS insfrastructure for the sample project.

# Requirements
* Terraform
* AWS cloud access
* Created Route53 zone in AWS account

# Resources that are created by Terraform:
* AWS VPC
* AWS RDS
* AWS Elasticache
* AWS EKS
* AWS KMS
* AWS ACM Certificates

# Infrastructure diagram:
![Digaram](diagram.png?raw=true "Digaram")
# How to Start infrastructure deployment process:
## Prerequsites
Steps must be done before applying Terraform configuration:
1. Create DynamoDB table for Terraform lock
1. Create S3 bucket to store tfstate file
1. Configure terraform backend, example: 
```
# terraform backend
key = "terraform/terraform.tfstate"
bucket = "tf-state-sampe-app"
dynamodb_table = "tf-state-sampe-app"
region = "us-west-2"
```

## Apply the code:
```
terraform init -backend-config=backend.conf
terraform plan -out=awsAccount-sample-app
terraform apply awsAccount-sample-app --auto-approve
```

# Variables:
All variables located in [variable](variables.tf?raw=true) file.


# Install applications
To install application run command:
```
kubectl apply -f ./k8s_manifests
```