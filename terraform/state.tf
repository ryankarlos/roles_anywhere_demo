terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tfstate_demo"
    key            = "rolesanywhere/terraform.tfstate"
    dynamodb_table = "state_ddb"
    encrypt        = true
    region         = "us-east-1"
  }
}
