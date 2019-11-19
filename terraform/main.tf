provider "aws" {
  region = "${var.aws_region}"
}

# Define our VPC
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "demo-vpc"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "demo-vpc-igw"
  }
}

# Define the route table for public subnet
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "public-subnet-rt"
  }
}

# Assign the route table for public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Create eip
resource "aws_eip" "eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

# Create nat gateway
resource "aws_nat_gateway" "nat" {
  depends_on    = ["aws_eip.eip"]
  subnet_id     = "${aws_subnet.public-subnet.*.id[count.index]}"
  allocation_id = "${aws_eip.eip.id}"
}

# Assign the route table to the private Subnet
resource "aws_route_table_association" "db-private-rt" {
  count = "${length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : 0}"
  subnet_id      = "${element(aws_subnet.private-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.db-private-rt.id}"
}

# Define route table for private subnet
resource "aws_route_table" "db-private-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat.id}"
  }

  tags {
    Name = "private-subnet-rt"
  }
}
#
# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "us-east-1a"

  tags {
    Name = "public-subnet"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = "${aws_vpc.default.id}"
  count             = "${length(var.private_subnet_cidr)}"
  cidr_block        = "${element(var.private_subnet_cidr, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name = "private-subnet-${count.index}"
  }
}

