provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-06d1e80aa22f0ebac"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
