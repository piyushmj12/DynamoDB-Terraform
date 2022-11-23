provider "aws" {
  region     = var.region
  #shared_credentials_files = ["C:/Users/piyush_yogi/.aws/credentials"]
}

resource "aws_iam_role" "lambda_role" {
  name = var.name_of_role


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    name = "my_lambda"
  }
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "lambda_policy"{
  name        = var.name_of_policy
  path        = "/"
  description = "Lambda's policy"


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:Describe*",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:lambda:${var.region}:${var.accountid}:function:${var.function_name}",
        "arn:aws:dynamodb:${var.region}:${var.accountid}:table/${var.dynamodbtable}"]
      },
    ]
  })
}

# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.lambda_policy.arn
}

# Generating an archive from content.

data "archive_file" "zip_the_python_code" {
 type        = "zip"
 source_dir  = "${path.module}/python/"
 output_path = "${path.module}/python/hello-python.zip"
}

resource "aws_lambda_function" "s3_dynamodb_func" {
 filename                       = "${path.module}/python/hello-python.zip"
 function_name                  = var.function_name
 role                           = aws_iam_role.lambda_role.arn
 handler                        = "hello-python.lambda_handler"
 runtime                        = var.runtime
 depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}







