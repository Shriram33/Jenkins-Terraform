variable "inout" {
  default = [22, 80 ]
}

resource "aws_security_group" "my_sec" {
    name = "ports_for_terraform"

    dynamic "ingress" {
    for_each = var.inout
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.inout
    content {
      from_port = egress.value
      to_port   = egress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "my_sec" {
  value = aws_security_group.my_sec.id
}
