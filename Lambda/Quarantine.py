import boto3
import os

def lambda_handler(event, context):
    instance_id = event["detail"]["resource"]["instanceDetails"]["instanceId"]
    ec2 = boto3.client("ec2")
    quarantine_sg_id = os.environ["QUARANTINE_SG_ID"]
    ec2.modify_instance_attribute(
        InstanceId=instance_id,
        Groups=[quarantine_sg_id]
    )
    print(f"Quarantined instance: {instance_id}")
    return {
        "statusCode": 200,
        "body": f"Instance {instance_id} quarantined successfully"
    }