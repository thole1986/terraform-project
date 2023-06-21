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
    path = "../terraform-infaIMSPOC/modules/networking/terraform.tfstate"
  }
}




