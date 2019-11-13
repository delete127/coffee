# Define webserver inside the public subnet
resource "aws_instance" "web" {
  ami                         = "${var.ami}"
  instance_type               = "t2.micro"
  key_name                    = "${var.keyname}"
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.web.id}"]
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${file("install.sh")}"
  count                       = 1
  
  tags {
    Name = "webserver-${count.index}"
  }
}

resource "aws_instance" "app" {
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "${var.keyname}"
  subnet_id              = "${aws_subnet.private-subnet.*.id[count.index]}"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  source_dest_check      = false
  user_data              = "${file("install.sh")}"
  count                  = 2

  tags {
    Name = "app-${count.index}"
  }
}
