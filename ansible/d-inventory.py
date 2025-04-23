#!/usr/bin/env python3

import boto3
import json

REGION = "us-east-1"

ec2 = boto3.resource('ec2', region_name=REGION)

instances = ec2.instances.filter(Filters=[
    {'Name': 'instance-state-name', 'Values': ['running']}
])

inventory = {}

bastion_ip = None
db_ip = None

for instance in instances:
    name_tag = next((tag['Value'] for tag in instance.tags if tag['Key'] == 'Name'), None)
    
    if name_tag == 'bastion_host': 
        bastion_ip = instance.public_ip_address

for instance in instances:
    name_tag = next((tag['Value'] for tag in instance.tags if tag['Key'] == 'Name'), None)
    
    if name_tag == 'db-ec2':
        db_ip = instance.private_ip_address
    
    if name_tag in ['fe-ec2', 'db-ec2']:
        inventory[name_tag] = {
            'ansible_ssh_host': instance.private_ip_address,
            'ansible_ssh_user': 'ec2-user',
            'ansible_ssh_private_key_file': '.ssh/id_rsa',
            'ansible_ssh_common_args': f"-J ec2-user@{bastion_ip}"
        }

if 'fe-ec2' in inventory and db_ip:
    inventory['fe-ec2']['db_host'] = db_ip

print(json.dumps(inventory, indent=2))
