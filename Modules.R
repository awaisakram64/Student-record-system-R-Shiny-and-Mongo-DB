clearFields <- function(session){
  updateTextInput(session,"std_fname",value = "")
  updateTextInput(session,"std_name",value = "")
  updateTextInput(session,"std_email",value = "")
  updateTextInput(session,"std_ph",value = "")
}


###----Connect with mongoDB

options(mongodb = list(
  "host" = "ds117109.mlab.com:17109",
  "username" = "awais",
  "password" = "awais1"
))
databaseName <- "adbms"
collectionName <- "responses"



saveData <- function(data) {
  # Connect to the database
  db <- mongo(collection = collectionName,
              url = sprintf(
                "mongodb://%s:%s@%s/%s",
                options()$mongodb$username,
                options()$mongodb$password,
                options()$mongodb$host,
                databaseName))
  # Insert the data into the mongo collection as a data.frame
  data <- as.data.frame(t(data))
  db$insert(data)
}

connectdb <- function() {
  # Connect to the database
  db <- mongo(collection = collectionName,
              url = sprintf(
                "mongodb://%s:%s@%s/%s",
                options()$mongodb$username,
                options()$mongodb$password,
                options()$mongodb$host,
                databaseName))
  # Read all the entries
}