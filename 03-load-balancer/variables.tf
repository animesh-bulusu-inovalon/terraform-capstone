variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "main-alb"
}

variable "blue_target_group_name" {
  description = "The name of the blue target group"
  type        = string
  default     = "blue-tg"
}

variable "green_target_group_name" {
  description = "The name of the green target group"
  type        = string
  default     = "green-tg"
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The interval for the health check in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The timeout for the health check in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks required to mark a target as healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health checks required to mark a target as unhealthy"
  type        = number
  default     = 3
}