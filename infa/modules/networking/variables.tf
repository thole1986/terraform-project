variable "project" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}

variable "private_subnet" {
  type = list(string)
}

variable "public_subnet" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}
variable "region" {
  type = string
}

variable "tags_name" {
  type = map(string)
}





