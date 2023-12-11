resource "aws_instance" "ec2_instance"{
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id   = var.subnet_id
}

provider "aws" {
  region = "ap-south-1"  # Change this to your desired region
}

