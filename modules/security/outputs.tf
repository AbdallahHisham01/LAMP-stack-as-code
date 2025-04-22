output "sg_fe_id" {
  value = aws_security_group.sg_fe.id
}

output "sg_be_id" {
  value = aws_security_group.sg_be.id
}

output "sg_db_id" {
  value = aws_security_group.sg_db.id
}

output "sg_bastion_id" {
  value = aws_security_group.sg_bastion.id
}
