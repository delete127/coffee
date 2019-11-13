# As per task this terraform will create below things:
1. 2 ec2 instance in different private subnet
2. 1 rds in private and accessiable from 2 ec2 instance
3. 1 nginx ec2 (user data for nginx installation) in public subnet
4. SG for application servers and SG for Nginx server
