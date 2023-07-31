# This file contains all variables


# Making region variable

variable "region-name" {
    type = string
    default = "eu-west-2"
    description = "making region variable."
}

# making vpc cidr variable

variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "making vpc cidr variable"
}

# making all subnets cidr blocks variable

variable "prod-pub-sub-1" {
  type = string
  default = "10.0.10.0/24"
  description = "making prod public subnet 1 cidr variable"
}

variable "prod-pub-sub-2" {
  type = string
  default = "10.0.11.0/24"
  description = "making prod public subnet 2 cidr variable"
}

variable "prod-priv-sub-1" {
  type = string
  default = "10.0.12.0/24"
  description = "making prod private subnet 1 cidr variable"
}

variable "prod-priv-sub-2" {
  type = string
  default = "10.0.13.0/24"
  description = "making prod private subnet 2 cidr variable"
}


# making all availability zones variable

variable "prod-pub-sub-1-az" {
  type = string
  default = "eu-west-2a"
  description = "making prod public subnet 1 availability zone variable"
}

variable "prod-pub-sub-2-az" {
  type = string
  default = "eu-west-2b"
  description = "making prod public subnet 2 availability zone variable"
}

variable "prod-priv-sub-1-az" {
  type = string
  default = "eu-west-2a"
  description = "making prod private subnet 1 availability zone variable"
}

variable "prod-priv-sub-2-az" {
  type = string
  default = "eu-west-2b"
  description = "making prod private subnet 2 availability zone variable"
}