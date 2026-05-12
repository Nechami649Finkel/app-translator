terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
   # Cerditional state
  backend "s3" {
    bucket = "nechami-s3-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1" 
     dynamodb_table = "terraform-lock-table" 
  }
 
}


provider "aws" {
  region = "us-east-1"
}
