variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}
variable "availability_zone" {
  default = "eu-west-1b"
}

variable "s3_name" {
  default = "sparkstoragedemo"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "bastion_ami" {
  description = "AMI for bastion server"
  default = "ami-d8106da1"
}

variable "aws_key_name" {
  description = "Key pair to nat access" #Create a key pair in AWS and specify the name here
  default = "euwest1keypair"
}

