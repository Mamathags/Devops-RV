# resource "aws_secretsmanager_secret" "rv_Secrets7" {
#   name = "rv_Secrets7"
# }

# resource "aws_secretsmanager_secret_version" "pemkeycreds" {
#   secret_id     = aws_secretsmanager_secret.rv_Secrets7.id
#   secret_string = tls_private_key.rsa.private_key_pem

# }

resource "aws_key_pair" "rv_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}


resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "rv_Pvtkey" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "rv_Pvtkey.pem"
}

#instance
resource "aws_instance" "bastion-host" {
  ami           = var.ami
  instance_type = var.instance_type
  /* vpc_id    =  var.vpc_id */
  subnet_id = var.subnet_public_1
  user_data = var.ec2_data
  # the security group
  vpc_security_group_ids = [aws_security_group.Bastion-sg.id]
  # the public SSH key
  # key_name = "rv_Pvtkey"
  key_name = var.key_name
  tags = {
    Name = var.bastion_host_name
  }
}

resource "aws_security_group" "Bastion-sg" {
  vpc_id      = var.vpc_id
  name        = "Bastion-sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   ingress {
  #     description     = "Allow traffic from application layer"
  #     from_port       = 3306
  #     to_port         = 3306
  #     protocol        = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"] 
  #  }
  #   ingress {
  #     description     = "Allow traffic from application layer"
  #     from_port       = 1433
  #     to_port         = 1433
  #     protocol        = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #  }

  #   ingress {
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  #   tags = {
  #     Name = "Bastion-sg"
  #   }
}
