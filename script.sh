#!/bin/bash

#Enable the Time to live of Dynamo Db Tables using this script.
#Usage : Give the names of the table while running the script with one space in each table's name
 
# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi
 
# Iterate over the provided table names
for table_name in "$@"; do
    # Enable TTL for the table with "expiryTime" attribute
    aws dynamodb update-time-to-live \
        --table-name "$table_name" \
        --time-to-live-specification "Enabled=true, AttributeName=expiryTime"
    if [ $? -eq 0 ]; then
        echo "TTL enabled for table $table_name with attribute expiryTime"
    else
        echo "Error enabling TTL for table $table_name"
    fi
done
