terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Configure the Snowflake Provider
provider "snowflake" {
  organization_name = "VSAQBDZ"
  account_name      = "RW35709"
  user              = "Jena"
  password          = "Dearest1"
}
