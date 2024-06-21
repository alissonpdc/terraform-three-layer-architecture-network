terraform {
  required_version = "~> 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      managed-by : "terraform"
      repo-name : var.repo_name
    }
  }
}