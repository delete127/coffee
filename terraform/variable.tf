variable "aws_region" {
  description = "Region for the VPC"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = "list"
  description = "CIDR for the private subnet"
  default     = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type        = "list"
  description = "azs for private subnets"
  default     = ["us-east-1b", "us-east-1c", "us-east-1d"]
}


variable "ami" {
  description = "Ubuntu 16.04"
  default     = "ami-04169656fea786776"
}

variable "keyname" {
  description = "aws key-pair name"
  default     = "k8s-my-acc"
}
