import boto3
import os

def lambda_handler(event, context):
    try:
        resource = event["detail"]["resource"]
        
        # only quarantine if it's an EC2 finding
        if resource.get("resourceType") != "Instance":
            print(f"Non-EC2 finding, skipping. Resource type: {resource.get('resourceType')}")
            return {"statusCode": 200, "body": "Non-EC2 finding, skipping"}
        
        instance_id = resource["instanceDetails"]["instanceId"]
        ec2 = boto3.client("ec2")
        quarantine_sg_id = os.environ["QUARANTINE_SG_ID"]
        
        ec2.modify_instance_attribute(
            InstanceId=instance_id,
            Groups=[quarantine_sg_id]
        )
        
        print(f"Quarantined instance: {instance_id}")
        return {"statusCode": 200, "body": f"Instance {instance_id} quarantined"}
    
    except Exception as e:
        print(f"Error: {str(e)}")
        raise