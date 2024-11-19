# Create a staging table that reads data from the stage
resource "snowflake_table" "table" {
  database = snowflake_database.database.name
  schema   = snowflake_schema.schema.name
  name     = "STAGING_TABLE"
  comment  = "Staging table that holds data from the stage"

  column {
    name     = "data"
    type     = "variant"
    nullable = false
  }
}