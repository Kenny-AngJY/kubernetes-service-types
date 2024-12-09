variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "create_vpc" {
  description = <<-EOT
  Choose whether to create a new VPC to deploy the EKS cluster in. 
  IF you want to use your own existing VPC, set this variable
  to "false" and define the vpc_id variable below.
  EOT
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "If create_vpc is false, define your own vpc_id."
  type        = string
  default     = ""
}

variable "list_of_subnet_ids" {
  description = "If create_vpc is false, define your own subnet_ids."
  type        = list(string)
  default     = []
}

variable "create_kms_key" {
  description = <<-EOT
    "Controls if a KMS key for cluster encryption should be created.
    Disabled by default as this cluster is just for testing/practice
    purposes."
  EOT

  type    = bool
  default = false
}

variable "create_rds" {
  description = <<-EOT
  Choose whether to create a 
  > aws_db_subnet_group
  > aws_db_parameter_group
  > aws_db_instance

  Set this to true if you want to try out the service 
  type of ExternalName, as seen in Figure 14 of the article.
  EOT

  type    = bool
  default = false
}

variable "use_eks_pod_identity_agent" {
  description = "Use IAM Roles for Service Account (IRSA) by default."
  type        = bool
  default     = false
}

variable "create_eks_worker_nodes_in_private_subnet" {
  type    = bool
  default = true
}