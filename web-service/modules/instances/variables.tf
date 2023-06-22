variable "tags_name" {
  type = map(string)
}

variable "servers" {
  type = map(string)
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "public_security_group_id" {
  type = string
}

variable "INSTANCE_USERNAME" {
  type    = string
  default = "ubuntu"
}

variable "SSH_PRIVATE_KEY" {
  default = "poc_ssh_key"
}

variable "SSH_PUBLIC_KEY" {
  default = "poc_ssh_key.pub"
}
