output "fe_instance_public_ip" {
  value = aws_instance.fe.public_ip
}

output "bastion_instance_public_ip" {
  value = aws_instance.bastion_host.private_ip
}

output "be_instance_public_ip" {
  value = aws_instance.be.private_ip
}

output "db_instance_public_ip" {
  value = aws_instance.db.private_ip
}