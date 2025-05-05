variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instances"
  type        = string
}

variable "desired_capacity" {
  description = "The desired capacity for the Auto Scaling groups"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum size for the Auto Scaling groups"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "The minimum size for the Auto Scaling groups"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instances"
  type        = string
}