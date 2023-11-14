terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = var.def_region
  shared_config_files      = ["/Users/sharmilas/.aws/config"]
  shared_credentials_files = ["/Users/sharmilas/.aws/credentials"]
  profile                  = "sharmi"
}
