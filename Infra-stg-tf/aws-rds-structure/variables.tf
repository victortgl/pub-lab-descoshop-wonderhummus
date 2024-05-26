variable "region" {
  description = "AWS REGION"
  type        = string
  default     = "us-east-1"
}
variable "db_instance_name" {
  default     = "rds-dcshp-stg"
  type        = string
}
variable "subnet_ids" {
  description = "SUBNETS dcshp-vpc"
  type        = list(string)
  default     = ["subnet-03914d352b4243940", "subnet-0166034195b52e3b7"]
}

variable "security_group_ids" {
  description = "SG dcshp-vpc"
  type        = list(string)
  default     = ["sg-01bccd80a2269cddd"]
}
variable "db_username" {
  description = "ADMIN USER RDS POSTGRES ACCESS - STG"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "ADMIN PASSWORD RDS POSTGRES ACCESS - STG"
  type        = string
  sensitive   = true
  default     = "^2Q9JVd3*llf"
}
