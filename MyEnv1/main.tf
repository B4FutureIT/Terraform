provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  #  ami                    = "ami-06d1e80aa22f0ebac"
  ami                    = "ami-06d1e80aa22f0ebac"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  count                  = 2 # Testing for maximum 20 instances

  user_data = <<-EOF
              #!/bin/bash
              echo "Welcome in my world ;)" > index.html
              nohup python3 -m http.server 8080 &
              EOF

  tags = {
    Name = "linux${count.index}"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-examaple-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
