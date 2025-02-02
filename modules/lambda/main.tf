# ECR Repository Data Source
data "aws_ecr_repository" "existing_repo" {
  name = "${var.project_name}-lambda"
}

# ECR Repository Resource (only created if it doesn't exist)
resource "aws_ecr_repository" "lambda_ecr" {
  count                = try(data.aws_ecr_repository.existing_repo.name, "") != "" ? 0 : 1
  name                 = "${var.project_name}-lambda"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Local Variable to Determine Which Repository URL to Use
locals {
  ecr_repository_url = try(data.aws_ecr_repository.existing_repo.repository_url, aws_ecr_repository.lambda_ecr[0].repository_url)
}

# Lambda Function Using the Determined ECR Repository URL
resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.project_name}-function"
  package_type  = "Image"
  image_uri     = "${local.ecr_repository_url}:latest"

  role        = var.role_arn
  timeout     = 30
  memory_size = 128

  environment {
    variables = {
      ENV = var.environment
    }
  }
}


# Output the ECR Repository URL
output "ecr_repository_url" {
  value = local.ecr_repository_url
}

