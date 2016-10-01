#!/bin/bash

#aws ec2 run-instances --image-id ami-06b94666 --key-name inclass --security-group-ids sg-1db27864 --instance-type t2.micro --user-data file://installenv.sh --count 3 --placement 
#AvailabilityZone=us-west-2b

#Instance=`aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Placement.AvailabilityZone, State.Name, InstanceId]' --output text | grep us-west-2b | grep running|pending | awk '{print 
#$3}'`

#echo "Instance id are $Instance"

#aws ec2 wait instance-running --instance-ids $Instance
aws elb create-load-balancer --load-balancer-name itmo-544 --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-cf82a1ab --security-groups sg-1db27864
 
#aws elb register-instances-with-load-balancer --load-balancer-name itmo-544 --instances $Instance

aws autoscaling create-launch-configuration --launch-configuration-name itmo-544-lcn --image-id $1 --security-groups sg-1db27864 --key-name inclass --instance-type t2.micro --user-data file://installenv.sh

aws autoscaling create-auto-scaling-group --auto-scaling-group-name server-rg --launch-configuration-name itmo-544-lcn --availability-zone us-west-2b --load-balancer-name itmo-544 --max-size 5 --min-size 2 --desired-capacity 3
