
#Create WEB_EC2 belong to private subnet
data "aws_ami" "ubuntu_web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "poc_key" {
  key_name   = "poc_ssh_key"
  public_key = file("${path.module}/${var.SSH_PUBLIC_KEY}")
}

data "cloudinit_config" "example" {
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/nginx.sh", {})
  }
}

resource "aws_instance" "web" {
  count           = length(var.subnet_id)
  ami             = data.aws_ami.ubuntu_web.id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id[count.index]
  key_name = aws_key_pair.poc_key.key_name
  vpc_security_group_ids = [var.public_security_group_id]
  user_data = data.cloudinit_config.example.rendered


  # root disk
  root_block_device {
    volume_size               = "8"
    volume_type               = "gp2"
    encrypted                 = false
    delete_on_termination     = true
  }

#  provisioner "file" {
##    source      = file("${path.module}/nginx.sh")
#    source      = file("/home/tholh/Desktop/terraform-project/web-service/modules/instances/nginx.sh")
#    destination = "/tmp/nginx.sh"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "chmod +x /tmp/nginx.sh",
#      "sudo /tmp/nginx.sh",
#    ]
#  }

#  connection {
#    host        = coalesce(self.public_ip, self.private_ip)
#    type        = "ssh"
#    user        = var.INSTANCE_USERNAME
#    private_key = file("${path.module}/${var.SSH_PRIVATE_KEY}")
#  }

  tags = {
    "Name"                      = "${var.servers["my_server_web"]}${count.index + 1}"
    "Environment"               = "${var.tags_name["my_environment"]}"
  }
}
