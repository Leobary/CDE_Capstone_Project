# Create an S3 Bucket
resource "aws_s3_bucket" "leo_cde_project" {
  bucket = "leo-cde-project"

  tags = {
    Name        = "CDE Capstone Project bucket"
    Environment = "Dev"
    owner       = "Leo"
    team        = "Core Data Engineers"
    managed_by  = "Mayowa"
  }
}


# Enable bucket versioning
resource "aws_s3_bucket_versioning" "leo_cde_project_versioning" {
  bucket = aws_s3_bucket.leo_cde_project.id
  versioning_configuration {
    status = "Enabled"
  }
}
