#!/bin/bash

url="https://example.com"

status=$(curl -s -o /dev/null -w "%{http_code}" https://google.com)

if [ "$status" = "200" ]
then
    echo "$(date) : Application is UP"
else
    echo "$(date) : Application is DOWN (status code: $status)"
fi