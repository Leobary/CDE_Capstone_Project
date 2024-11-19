# Create a file format
resource "snowflake_file_format" "file_format" {
  name        = "PARQUET_FORMAT"
  database    = snowflake_database.database.name
  schema      = snowflake_schema.schema.name
  format_type = "PARQUET"
  compression = "SNAPPY"
}
