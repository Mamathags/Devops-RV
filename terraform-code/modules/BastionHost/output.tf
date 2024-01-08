output "bastion-sg" {
  value = aws_security_group.Bastion-sg.id
}

output "bastion-private-ip" {
  value = aws_instance.bastion-host.private_ip
}

output "bastion-public-ip" {
  value = aws_instance.bastion-host.public_ip
}

output "bastion-sg-id" {
  value = aws_security_group.Bastion-sg.id
}

