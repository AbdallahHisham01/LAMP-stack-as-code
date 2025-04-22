resource "aws_key_pair" "key" {
  key_name   = "abdallah_key"
  public_key = file("./.ssh/id_rsa.pub")
}

module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "compute" {
  source = "./modules/compute"

  public_subnet_1_id  = module.network.public_subnet_1_id
  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id
  key_name            = aws_key_pair.key.key_name

  sg_fe_id      = module.security.sg_fe_id
  sg_be_id      = module.security.sg_be_id
  sg_db_id      = module.security.sg_db_id
  sg_bastion_id = module.security.sg_bastion_id
}
