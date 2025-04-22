variable "public_subnet_1_id" {}
variable "private_subnet_1_id" {}
variable "private_subnet_2_id" {}
variable "key_name" {}
variable "sg_fe_id" {}
variable "sg_be_id" {}
variable "sg_db_id" {}
variable "sg_bastion_id" {}
variable "ami" {
  default =  "ami-0e449927258d45bc4" # amazon linux machine
}
variable "instance_type" {
  default = "t2.micro"
}