
#Create WEB_EC2 belong to private subnet
data "aws_ami" "ubuntu_web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230112"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  count           = length(var.subnet_id)
  ami             = data.aws_ami.ubuntu_web.id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id[count.index]
  # key_name        = "jenkin-ssh"

  # root disk
  root_block_device {
    volume_size               = "8"
    volume_type               = "gp2"
    encrypted                 = false
    delete_on_termination     = true
  }

  tags = {
    "Name"                      = "${var.servers["my_server_web"]}${count.index + 1}"
    "Environment"               = "${var.tags_name["my_environment"]}"
  }
}
