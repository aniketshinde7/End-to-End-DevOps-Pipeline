provider "aws" {
    region = "ap-south-1" 
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH, HTTP, HTTPS, and Docker ports"

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "ec2" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  vpc_security_group_ids =  [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3
              EOF
  tags = {
    Name = "Terraform-EC2"
  }
}