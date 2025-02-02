# Terraform AWS Lambda and API Gateway Setup

This project uses Terraform to deploy an AWS Lambda function and an API Gateway. The Lambda function's source code is fetched from a Bitbucket URL, and the API Gateway is configured to trigger the Lambda function.

## Project Structure
terraform-setup ├── modules │ ├── api_gateway │ │ ├── main.tf │ │ ├── outputs.tf │ │ └── variables.tf │ ├── lambda │ │ ├── main.tf │ │ ├── outputs.tf │ │ └── variables.tf │ └── iam │ ├── main.tf │ ├── outputs.tf │ └── variables.tf ├── main.tf ├── outputs.tf ├── variables.tf └── README.md


## Prerequisites

- Terraform installed
- AWS CLI configured with appropriate permissions
- Bitbucket repository URL for the Lambda function source code

## Usage

1. Clone the repository.
2. Initialize Terraform:
   ```sh
   terraform init