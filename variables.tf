variable "region" {
  description = "The AWS region we want this bucket to live in."
}

variable "bucket" {
    description = "The name of the bucket to be created"
}

variable "runtime" {
    description = "The runtime which you want to use"
    default = "python3.9"
}

variable "function_name" {
    description = "The name of the lambda function"
    default = "Piyush_lambda_function"
}

variable "name_of_role" {
    description = "The name of role of lambda function"
}

variable "name_of_policy" {
    description = "The name of role of lambda function"
}

variable "dynamodbtable" {
    description = "The name of the dyanmoDB table"
    default = "DynamoDB-Terraform"
}


variable "accountid" {
    description = "The account id no is."
    default = "Give your account id"
}
