provider "aws" {
    region = "ap-south-1"
}

# It will fech the AMI-ID of AWS-AMI2

data "aws_ami" "fetch_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

locals {
  insta = "t2.micro"
}

# Creating the Ansible Control machine #

resource "aws_instance" "control" {
  ami = data.aws_ami.fetch_ami.id
  instance_type = local.insta
  tags = {
    name = "Ansible_Control_Node"
}
 
