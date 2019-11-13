# create rds
resource "aws_db_instance" "private-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  identifier           = "demo-rds"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot       = true
  db_subnet_group_name = "${aws_db_subnet_group.db-subnet.name}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  depends_on  = ["aws_security_group.app"]
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = "rds-private-subnet-group"
  subnet_ids = ["${aws_subnet.private-subnet.*.id}"]
}
