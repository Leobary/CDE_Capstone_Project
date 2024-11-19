# Create a database
resource "snowflake_database" "database" {
  name                           = "CDE_PROJECT_DB"
  comment                        = "Database to use for capstone project"
  drop_public_schema_on_creation = true
}
