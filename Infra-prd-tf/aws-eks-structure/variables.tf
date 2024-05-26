
variable "region" {
  description = "AWS REGION"
  default     = "us-east-1"
}

variable "eks_cluster_name" {
  description = "EKS K8S NAME"
  default     = "dcshp-eks-cluster-prd"
}

variable "subnet_ids" {
  description = "SUBNETS dcshp-vpc"
  type        = list(string)
  default     = ["subnet-03914d352b4243940", "subnet-0166034195b52e3b7"]
}

variable "security_group_id" {
  description = "SG dcshp-vpc"
  type        = list(string)
  default     = ["sg-01bccd80a2269cddd"]
}
variable "gfn_security_group_id" {
  description = "SG GRAFANA dcshp-vpc"
  type        = string
  default     = "sg-01bccd80a2269cddd"
}
variable "ec2_instance_name" {
  description = "EC2 TAG"
  default     = "dcshp-eks-node-prd"
}

variable "desired_capacity" {
  description = "NODES WORKS NUMBER"
  default     = 1
}

variable "max_capacity" {
  description = "MAX WORKS NODES NUMBER - SCALING"
  default     = 2
}

variable "min_capacity" {
  description = "MIN WORKS NODES NUMBER - SCALING"
  default     = 1
}

variable "instance_types" {
  description = "EC2 NODE INSTANCE - FAMILY"
  default     = ["t2.micro"]
}

variable "disk_size" {
  description = "NODE DISK SIZE - EC2"
  default     = 20
}
variable "gf_username" {
  description = "ADMIN USER GRAFANA ACCESS - PRD"
  type        = string
  default     = "grafana"
}

variable "gf_password" {
  description = "ADMIN PASSWORD GRAFANA ACCESS - PRD"
  type        = string
  sensitive   = true
  default     = "^2Q9JVd3*llf"
}
