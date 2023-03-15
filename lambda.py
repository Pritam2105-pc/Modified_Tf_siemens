#import boto3
#import requests
client = boto3.client('EC2')
def lambda_handler(event, context):
    Instance_id = event['detail']['instance-id']
    topic_arn = 'arn_of_sns_alerts'
    message = 'your server ' + Instance_id + 'is down'
    client.publish(TopicArn=topic_arn,Message=message)
response = requests.get("https://2xfhzfbt31.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data")
print(response)