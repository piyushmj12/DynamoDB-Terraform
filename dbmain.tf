provider "aws" {
  alias  = "us-east-1"  
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

resource "aws_dynamodb_table" "us-east-1" {
  provider = aws.us-east-1

  name           = "DynamoDB-Terraform"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  hash_key       = "Object_Name"
  range_key      = "Object_Type"

  attribute {
    name = "Object_Name"
    type = "S"
  }

  attribute {
    name = "Object_Type"
    type = "S"
  }
  
}

resource "aws_dynamodb_table" "us-west-2" {
  provider = aws.us-west-2

  name           = "DynamoDB-Terraform"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  hash_key       = "Object_Name"
  range_key      = "Object_Type"

  attribute {
    name = "Object_Name"
    type = "S"
  }

  attribute {
    name = "Object_Type"
    type = "S"
  }

}

resource "aws_dynamodb_global_table" "replication_enabled_table" {
  depends_on = [
    aws_dynamodb_table.us-east-1,
    aws_dynamodb_table.us-west-2,
  ]
  provider = aws.us-east-1

  name = "DynamoDB-Terraform"

  replica {
    region_name = "us-east-1" 
  }

  replica {
    region_name = "us-west-2"
}
}
