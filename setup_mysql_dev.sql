#!/bin/bash

DB_NAME="hbnb_dev_db"
DB_USER="hbnb_dev"
DB_PASSWORD="hbnb_dev_pwd"

# Check if the database exists
if mysql -u root -e "use $DB_NAME"; then
  echo "Database $DB_NAME already exists."
else
  # Create the database
  echo "Creating database $DB_NAME..."
  mysql -u root -e "CREATE DATABASE $DB_NAME;"
  echo "Database $DB_NAME created."
fi

# Check if the user exists
if mysql -u root -e "SELECT user FROM mysql.user WHERE user='$DB_USER'" | grep $DB_USER; then
  echo "User $DB_USER already exists."
else
  # Create the user
  echo "Creating user $DB_USER..."
  mysql -u root -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
  echo "User $DB_USER created."
fi

# Grant privileges to the user
echo "Granting privileges to $DB_USER on $DB_NAME..."
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql -u root -e "GRANT SELECT ON performance_schema.* TO '$DB_USER'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"
echo "Privileges granted."

echo "MySQL server is prepared for the project."
