# Create a stage to connect s3 bucket
resource "snowflake_stage" "cde_project_stage" {
  name        = "CDE_PRJ_S3_STAGE"
  url         = "s3://leo-cde-project/transformed_data/"
  database    = snowflake_database.database.name
  schema      = snowflake_schema.schema.name
  credentials = "AWS_KEY_ID='${aws_iam_access_key.airflow_access_key.id}' AWS_SECRET_KEY='${aws_iam_access_key.airflow_access_key.secret}'"
}