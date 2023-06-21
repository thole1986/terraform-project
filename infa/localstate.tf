terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "local" {
    path = "modules/networking/terraform.tfstate"
  }
}




