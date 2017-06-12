#!/bin/bash
set -o errexit
set -o pipefail

# For URL parsing...
. /usr/local/bin/utilities.sh
PROPERTIES_FILE=/opt/mirthconnect/conf/mirth.properties

# Start NGiNX reverse proxy
/usr/sbin/nginx

# If DATABASE_URL is defined (and is a postgresql:// URL), replace the
# default in-container Derby database connection with a PostgreSQL connection
if [ -n "$DATABASE_URL" ]; then
  parse_url "$DATABASE_URL"

  if [ "$protocol" != "postgresql://" ]; then
    echo "ERROR: DATABASE_URL must be a postgresql:// URL"
    exit 1
  fi

  sed -i "s/^database =.*/database = postgres/" $PROPERTIES_FILE
  sed -i "s/^database.url =.*/database.url = jdbc:postgresql:\/\/${host_and_port}\/${database}\?ssl=true\&sslfactory=org.postgresql.ssl.NonValidatingFactory/" $PROPERTIES_FILE
  sed -i "s/^database.username =/database.username = ${user}/" $PROPERTIES_FILE
  sed -i "s/^database.password =/database.password = ${password}/" $PROPERTIES_FILE
fi

# Launch Mirth Server
java -jar mirth-server-launcher.jar
