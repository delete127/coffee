# coffee
# This repository contains two directories.
1. terraform: which will create aws infra 
2. elasticsearch_cluster: for ES deployment in cluster mode

Task 1:
1. 2 ec2 instance in different private subnet
2. 1 rds in private and accessiable from 2 ec2 instance
3. 1 nginx ec2 (user data for nginx installation) in public subnet
4. SG for application servers and SG for Nginx server

Task 2:
1. ansible role for 3 node ES cluster where 1 master and 2 data nodes
