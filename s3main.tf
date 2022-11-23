resource "aws_s3_bucket" "s3_get_bucket" {
  bucket = var.bucket

}

resource "aws_s3_bucket_acl" "private_bucket" {
  bucket = aws_s3_bucket.s3_get_bucket.id
  acl    = "private"
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_get_bucket.id



  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_dynamodb_func.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_prefix       = ""
    filter_suffix       = ""
  }

  depends_on = [aws_lambda_permission.allow_bucket]
  
}


resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:*"
  function_name = aws_lambda_function.s3_dynamodb_func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.s3_get_bucket.arn
}


#Uploadind tfstate file to S3 bucket
/*terraform {
  backend "s3"{
    bucket = "piyushyogi121998"
    key = "mystatefile/terraform.tfstate"
    region = "ap-south-1"

  }
}
*/

