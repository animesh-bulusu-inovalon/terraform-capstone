variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/28"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.0.16/28"
}

variable "availability_zone_public" {
  description = "The availability zone for the public subnet"
  type        = string
  default     = "eu-north-1a"
}

variable "availability_zone_private" {
  description = "The availability zone for the private subnet"
  type        = string
  default     = "eu-north-1b"
}