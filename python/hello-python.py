import boto3
import urllib
import mimetypes

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('DynamoDB-Terraform')

def lambda_handler(event, context):
    s3_client = boto3.client('s3') 
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object = event['Records'][0]['s3']['object']['key']
    object = urllib.parse.unquote_plus(object, encoding='utf-8')
    
    message = 'The object is ' + object + ' and bucket name is ' + bucket_name
    print(message)
    
    objecttype = mimetypes.guess_type(object)[0]
    response = table.put_item(
        Item={
            'Object_Name': object,
            'Object_Type': objecttype
            })
    return {
        'statusCode': 200,
    }
