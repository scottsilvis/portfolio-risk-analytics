library(DBI)
library(RSQLite)
library(yaml)

connect_db <- function(config_path = "config/config.yaml") {

  cfg <- yaml::read_yaml(config_path)

  if (is.null(cfg$database) || is.null(cfg$database$path)) {
    stop("Missing `database.path` in config/config.yaml")
  }

  db_path <- cfg$database$path

  if (!file.exists(db_path)) {
    stop(paste0("SQLite database not found at:  ", db_path))
  }

  message("DB found at", db_path)

  DBI::dbConnect(RSQLite::SQLite(), dbname = db_path)

  message("dbIsValid: ", DBI::dbIsValid(conn))

  return(conn)
}