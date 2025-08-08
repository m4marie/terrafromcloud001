provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

variable "instance_count" {
  default = 4
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type for us-east-1"
  default     = "ami-0c02fb55956c7d316" # Update this to your region's AMI if needed
}

variable "key_name" {
  description = "Name of an existing EC2 Key Pair"
  type        = string
}

resource "aws_instance" "ec2_instances" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "Terraform-EC2-${count.index + 1}"
  }
}

output "instance_public_ips" {
  value = aws_instance.ec2_instances[*].public_ip
}

