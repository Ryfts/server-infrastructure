variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "ryfts-zone" {
  default = "ap-southeast-1a"
}

variable "ryfts-cidr_block" {
  default = "10.0.1.0/24"
}

variable "ryfts-eip_id" {
  default = "eipalloc-c0148afa"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "ap-southeast-1"
}

resource "aws_vpc" "ryfts" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "Ryfts VPC"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-remote-state-ryfts"
    key    = "ryfts-io-state/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

resource "aws_subnet" "ryfts" {
  vpc_id = "${aws_vpc.ryfts.id}"
  cidr_block = "${var.ryfts-cidr_block}"
  availability_zone = "${var.ryfts-zone}"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ryfts" {
  vpc_id = "${aws_vpc.ryfts.id}"
}

resource "aws_route_table" "ryfts" {
  vpc_id = "${aws_vpc.ryfts.id}"
  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.ryfts.id}"
  }
}

resource "aws_route_table_association" "ryfts" {
  subnet_id = "${aws_subnet.ryfts.id}"
  route_table_id = "${aws_route_table.ryfts.id}"
}

resource "aws_security_group" "ryfts-app" {
  name = "ryfts app"
  description = "Security group for the application"
  vpc_id = "${aws_vpc.ryfts.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = "${file("terraform_key.pub")}"
}

resource "aws_instance" "ryfts-app" {
  ami = "ami-e6d3a585"
  instance_type = "t2.micro"
  tags {
    Name = "ryfts-app"
  }
  root_block_device {
    volume_size = "200"
    volume_type = "gp2"
  }
  subnet_id = "${aws_subnet.ryfts.id}"
  associate_public_ip_address = true

  key_name = "${aws_key_pair.terraform.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ryfts-app.id}"]
}

resource "aws_eip_association" "ryfts-eip_assoc" {
  instance_id   = "${aws_instance.ryfts-app.id}"
  allocation_id = "${var.ryfts-eip_id}"
}
