# Create a user for Airflow to access AWS
resource "aws_iam_user" "airflow_user" {
  name = "cde_prj_airflow_user"

  tags = {
    Name        = "Airflow User"
    Environment = "Dev"
    owner       = "Leo"
    team        = "Core Data Engineers"
    managed_by  = "Mayowa"
    service     = "Airflow"
  }
}


# Create access key and secret key for airflow_user to access AWS
resource "aws_iam_access_key" "airflow_access_key" {
  user = aws_iam_user.airflow_user.name
}


# Store access and secret keys using AWS SSM parameters
resource "aws_ssm_parameter" "airflow_access_key" {
  name        = "/cde/project/airflow/access_key"
  description = "The access key for Airflow user"
  type        = "String"
  value       = aws_iam_access_key.airflow_access_key.id

  tags = {
    Name        = "Airflow User"
    Environment = "Dev"
    owner       = "Leo"
    team        = "Core Data Engineers"
    managed_by  = "Mayowa"
    service     = "Airflow"
  }
}

resource "aws_ssm_parameter" "airflow_secret_key" {
  name        = "/cde/project/airflow/secret_key"
  description = "The secret key for Airflow user"
  type        = "String"
  value       = aws_iam_access_key.airflow_access_key.secret

  tags = {
    Name        = "Airflow User"
    Environment = "Dev"
    owner       = "Leo"
    team        = "Core Data Engineers"
    managed_by  = "Mayowa"
    service     = "Airflow"
  }
}


# Create IAM policy to be used by Airflow user to read and write to AWS S3
resource "aws_iam_policy" "airflow_policy" {
  name        = "cde_prj_airflow_policy"
  description = "IAM policy used by Airflow to access AWS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:*Object*",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::leo-cde-project",
          "arn:aws:s3:::leo-cde-project/*"
        ]
      }
    ]
  })
}


# Attach the Airflow policy and Airflow user above together
resource "aws_iam_user_policy_attachment" "airflow_policy_attach" {
  user       = aws_iam_user.airflow_user.name
  policy_arn = aws_iam_policy.airflow_policy.arn
}
