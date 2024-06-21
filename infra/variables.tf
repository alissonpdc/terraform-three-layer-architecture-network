# GIT VARIABLE
variable "repo_name" {
  type        = string
  description = "value"
}


# NETWORK VARIABLES
variable "aws_region" {
  type        = string
  description = "value"
  default     = "us-east-1"
}
variable "vpc_name" {
  type        = string
  description = "value"
  default     = "app-vpc"
}
variable "vpc_cidr" {
  type        = string
  description = "value"
  default     = "10.0.0.0/16"
}
variable "public_subnets" {
  type        = map(string)
  description = "value"
  default = {
    public-1a = "10.0.1.0/24"
    public-1b = "10.0.2.0/24"
    public-1c = "10.0.3.0/24"
  }
}
variable "private_app_subnets" {
  type        = map(string)
  description = "value"
  default = {
    private-1a-app = "10.0.10.0/24"
    private-1b-app = "10.0.20.0/24"
    private-1c-app = "10.0.30.0/24"
  }
}
variable "private_db_subnets" {
  type        = map(string)
  description = "value"
  default = {
    private-1a-db = "10.0.11.0/24"
    private-1b-db = "10.0.21.0/24"
    private-1c-db = "10.0.31.0/24"
  }
}


# NATGW VARIABLES
variable "natgw_instance_type" {
  type        = string
  description = "value"
  default     = "t3a.nano"
}