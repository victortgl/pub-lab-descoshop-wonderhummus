variable "region" {
  description = "AWS REGION"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR dcshp-vpc"
  default     = "10.1.0.0/23"
}

variable "subnet_cidrs" {
  description = "Subnets dcshp-vpc"
  default     = ["10.1.1.0/24"]
}

variable "azs" {
  description = "Zonas dcshp-vpc"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "default_name" {
  default     = "dcshp-vpc-stg"
}