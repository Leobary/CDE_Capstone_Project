# Create a schema
resource "snowflake_schema" "schema" {
  name     = "PROJECT"
  database = snowflake_database.database.name
  comment  = "My project schema"
}