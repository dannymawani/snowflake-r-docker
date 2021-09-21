# Script version v1.0
# Original Author: Zohar Nissare-Houssen
# E-mail: z.nissare-houssen@snowflake.com
# Modified by Danny Mawani Holmgaard
# Website www.mawani.dk
#
# README:
#     - Please check the following URLs for the driver to pick up:
#         ODBC:  https://sfc-repo.snowflakecomputing.com/odbc/linux/index.html
#         JDBC:  https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/


#!/bin/bash

#export odbc_version=${odbc_version:-2.19.16}

export odbc_version=${odbc_version:-2.23.2}
export odbc_file=${odbc_file:-snowflake_linux_x8664_odbc-${odbc_version}.tgz}
export jdbc_version=${jdbc_version:-3.9.2}
export jdbc_file=${jdbc_file:-snowflake-jdbc-${jdbc_version}.jar}
export snowsql_version=${snowsql_version:-1.1.85}
export bootstrap_version=`echo ${snowsql_version}|cut -c -3`
export snowsql_file=${snowsql_file:-snowsql-${snowsql_version}-linux_x86_64.bash}
cd /

echo "Downloading odbc driver version" ${odbc_version} "..."
curl -O https://sfc-repo.snowflakecomputing.com/odbc/linux/${odbc_version}/${odbc_file}

echo "Downloading jdbc driver version" ${jdbc_version} "..."
curl -O https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${jdbc_version}/${jdbc_file}

echo "Download SnowSQL client version" ${snowsql_version} "..."
curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/${bootstrap_version}/linux_x86_64/${snowsql_file}

tar -xzvf ${odbc_file}
./snowflake_odbc/iodbc_setup.sh

SNOWSQL_DEST=/usr/bin #SNOWSQL_LOGIN_SHELL=/home/rstudio/.Rprofile bash /${snowsql_file}
