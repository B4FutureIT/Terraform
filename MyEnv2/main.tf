provider "aws" {
  version = "2.69"

  region = "us-west-2" # Oregon
}

resource "aws_instance" "example" {
  ami           = "ami-0528a5175983e7f28"
  instance_type = "t2.micro"
  # vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id = aws_subnet.example_subnet.id

  root_block_device {
    volume_size           = 10
    volume_type           = "gp2" # General Purpose SSD
    delete_on_termination = true
  }

  tags = {
    Name = "linux"
  }
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "192.168.100.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = "Web VPC"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = "192.168.100.0/25" // This is a subset of the VPC's CIDR block
  availability_zone = "us-west-2a"
  #  map_public_ip_on_launch = true // Enable public IP on instances

  tags = {
    Name = "Example Subnet"
  }
}
