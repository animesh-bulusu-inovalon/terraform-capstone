terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }

  required_version = ">= 1.11.0"
}

provider "aws" {
  region  = "eu-north-1"
  profile = "acc1025iam"
}
