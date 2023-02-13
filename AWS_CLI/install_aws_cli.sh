#!/bin/bash

echo  "installing AWS CLI locally"

# Get installer on to local machine

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip AWS CLI in a location you have permission

sudo unzip awscliv2.zip -d /usr/local

cd /usr/local/aws/

sudo ./install