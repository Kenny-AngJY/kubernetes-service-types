output "rds_hostname" {
  description = "RDS instance hostname"
  value       = var.create_rds ? module.rds[0].rds_hostname : ""
}

output "rds_port" {
  description = "RDS instance port"
  value       = var.create_rds ? module.rds[0].rds_port : ""
}

output "rds_username" {
  description = "RDS instance root username"
  value       = var.create_rds ? module.rds[0].rds_username : ""
}