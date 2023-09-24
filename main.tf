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

# Creating the Ansible Remote machine #

resource "aws_instance" "remote" {
  ami = data.aws_ami.fetch_ami.id
  instance_type = local.insta
  count = 2
  tags = {
    name = "Ansible_Remote_Node.${count.index}"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    on_failure = "continue"
    inline = [ 
      "sudo install -y python"
     ]
  }
}

output "ip_of_remote_node" {
  value = aws_instance.remote[*].public_ip
}

# Creating the Ansible Control machine #

resource "aws_instance" "control" {
  ami = data.aws_ami.fetch_ami.id
  instance_type = local.insta
  tags = {
    name = "Ansible_Control_Node"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    on_failure = "continue"
    inline = [ 
      "sudo amazon-linux-extras install -y ansible2"
     ]
  }
}

locals {
  insta = "t2.micro"
}
