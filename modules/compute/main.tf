resource "aws_instance" "fe" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_1_id
  key_name = var.key_name
  associate_public_ip_address = true
  security_groups = [ var.sg_fe_id ]
  tags = {
    Name = "fe-ec2"
  }
}

resource "aws_instance" "bastion_host" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_1_id
  key_name = var.key_name
  associate_public_ip_address = true
  security_groups = [ var.sg_bastion_id ]
  tags = {
    Name = "bastion_host"
  }
}

resource "aws_instance" "be" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.private_subnet_1_id
  key_name = var.key_name
  associate_public_ip_address = false
  security_groups = [ var.sg_be_id ]
  tags = {
    Name = "be-ec2"
  }
}

resource "aws_instance" "db" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.private_subnet_2_id
  key_name = var.key_name
  associate_public_ip_address = false
  security_groups = [ var.sg_db_id ]
  tags = {
    Name = "db-ec2"
  }
}
