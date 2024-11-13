variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "vpc_id" {
  type = string
}