#!/bin/bash

# Get MFA device ARN and token code from user input
read -p "Enter MFA device ARN: " mfa_device_arn
read -p "Enter MFA token code: " mfa_token_code

# Run aws sts get-session-token command and capture output
aws_session_token=$(aws sts get-session-token --serial-number $mfa_device_arn --token-code $mfa_token_code \
--output text --query 'Credentials.[AccessKeyId, SecretAccessKey, SessionToken]')

# Parse output and export to bash environment variables
export AWS_ACCESS_KEY_ID=$(echo $aws_session_token | awk '{print $1}')
export AWS_SECRET_ACCESS_KEY=$(echo $aws_session_token | awk '{print $2}')
export AWS_SESSION_TOKEN=$(echo $aws_session_token | awk '{print $3}')

# Print success message
echo "Session token obtained and exported to environment variables."
