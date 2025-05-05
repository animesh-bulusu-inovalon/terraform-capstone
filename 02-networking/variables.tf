variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "availability_zone_public" {
  description = "The availability zone for the public subnet"
  type        = string
}

variable "availability_zone_private" {
  description = "The availability zone for the private subnet"
  type        = string
}