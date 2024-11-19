# Create a backend state file
terraform {
  backend "s3" {
    bucket  = "leo-cde-project-backend"
    key     = "terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
