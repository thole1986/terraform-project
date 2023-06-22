terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

}


data "terraform_remote_state" "networking" {
  backend = "local"

  config = {
    path = "../infa/modules/networking/terraform.tfstate"
  }
}




