variable "region1" {
  description = "The AWS region we want this bucket to live in."
  default     = "us-east-1"
}

variable "bucket" {
    description = "The name of the bucket to be created"
    default = "piyushyogi121998"
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
    default = "my_rolee11"
}

variable "name_of_policy" {
    description = "The name of role of lambda function"
    default = "my_policyy11"
}

variable "dynamodbtable" {
    description = "The name of the dyanmoDB table"
    default = "DynamoDB-Terraform"
}


variable "accountid" {
    description = "The account id no is."
    default = "406210002387"
}

variable "region2" {
    default = "us-east-1"
}