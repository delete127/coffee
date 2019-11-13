# Define the security group for private subnet
resource "aws_security_group" "rds" {
  name        = "rds_sg"
#  depends_on  = ["aws_security_group.app"]
  description = "Allow traffic from private subnet"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "rds-sg"
  }
}
