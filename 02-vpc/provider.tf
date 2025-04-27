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

terraform {
  backend "s3" {
    bucket       = "animeshbulusu-infrastatefiles-apr2025-02"
    key          = "02-vpc/02-vpc.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
  }
}