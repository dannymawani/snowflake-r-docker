# docker
1. To build the image, Write ```docker build --tag dev:latest .``` in your terminal where you have changed the directory to the folder the docker file is in.
   
2. Write ```docker run -d -p 8787:8787  -e PASSWORD=1234 dev:latest``` 

    (replace pass to your liking). If you want, you can mount a directory with a project to work on like this: 

    ```docker run --rm -p 8787:8787 -v C:/Users/DannysComputer/Documents/rstudio:/home/rstudio -e PASSWORD=1234 dev:latest```

    In order to just execute a script you can use:

    ```docker 
    docker run dev:latest Rscript -e 'source("/home/rstudio/main.R")' 
    ```
   
3. You can now log in at
http://localhost:8787/

# Connect to snowflake
Use this to set up a connection to Snowflake:
```r
#Load libraries
library(tidyverse)
library(odbc)
library(DBI)
#log in
con <- DBI::dbConnect(
  drv    = odbc::odbc(), 
  UID    = "username", 
  PWD    = "password", 
  Server = "yourAccount.west-europe.azure.snowflakecomputing.com",
  Warehouse = 'COMPUTE_WH',
  Driver = "SnowflakeDSIIDriver",
  Database = "yourDataBase",
  Schema = "yourSchema")
```
Alternatively, you can edit the odbc.ini file included in this repo and connect by running:

```r
con <- dbConnect(odbc(), "snowflake")
```
# Using snowflake with R and Tidyverse commands
Below is some examples of things you can do after you have set up your connection with Snowflake

```r
#Connect to a table or view
df <- tbl(con, 'yourTableName')

#Full load table
data <- df%>%collect

#Load 10 rows
data <- head(10)%>%collect

#add table
dbCreateTable(con, "iris", iris)

#remove table
dbRemoveTable(con, "iris")

#upload data
dbWriteTable(con, "iris", iris, overwrite = TRUE, row.names = FALSE)