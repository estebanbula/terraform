# Defines de aws provider
provider "aws" {
  region = "us-east-1"
}

# Datasource to get the default vpc id
data "aws_vpc" "default" {
  default = true
}

# Defines the EC2 instance
resource "aws_instance" "terraform_ec2" {
  ami                    = "ami-0e8a34246278c21e4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  # Utiliza esto para tus datos de usuario
  # Instala httpd (Version: Linux 2)
  apt-get update
   install httpd
  systemctl start httpd
  systemctl enable httpd
  echo "<h1>Hola Mundo desde $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "ec2-server-1"
  }
}

# Defines a security group
resource "aws_security_group" "terraform_sg" {
  name   = "terraform-sg-one"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access to 80 port from the outside"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access to 22 port"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access to the outside"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }
}
