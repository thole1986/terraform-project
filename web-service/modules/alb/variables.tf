variable "vpc_id" {}

variable public_subnets {
    type = list(string)
}

variable "instance_ids" {
  type = list(string)
}