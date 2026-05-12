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
    region = "us-east-1" # ודאי שזה זהה לשורה 11
  }
}

provider "aws" {
  region = "us-east-1" # האזור של המשאבים שאת יוצרת
}
}



provider "aws" {
  region = "us-east-1"
}
