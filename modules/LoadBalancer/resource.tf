provider "aws" {
  region = "ap-south-1"  # Change this to your desired region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}
# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}


resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
}


resource "aws_security_group" "alb_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "telb" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  health_check {
    path     = "/"
    protocol = "HTTP"
    port     = "traffic-port"
  }
}


resource "aws_lb" "load_balancer" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  enable_deletion_protection = false  # Set to true if you want to prevent accidental deletion
}




