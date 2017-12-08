import boto.ec2
import sys
import paramiko
import time

autoScalingGroups = [['pb-lg', 'HostSG1']]
for asg in autoScalingGroups:
    conn = boto.ec2.connect_to_region("us-east-1",aws_access_key_id='AKIAJX5GCTO72BO55PLQ ',aws_secret_access_key='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')
    reservations = conn.get_all_instances(filters={"tag:aws:autoscaling:groupName" : asg[0]})
    list_instances = ""
    for reservation in reservations:
        instances = reservation.instances
        for instance in instances:
            if instance.state=='running':
                list_instances = list_instances + instance.private_ip_address + " "
        host_list = str(asg[1]) + "=("+list_instances+")"
        print(host_list)

