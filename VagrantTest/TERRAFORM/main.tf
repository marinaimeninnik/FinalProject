terraform{
    required_providers {
        aws = {
            source  = "registry.terraform.io/hashicorp/aws"
            version = "~> 4.48.0"
            
        }
    }
}
provider aws {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region     = "${var.AWS_REGION}"
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230207"]
        # values = ["ubuntu/images/ubuntu-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_instance" "Ubuntu2004" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"

    tags = {
       Name = "Ubuntu Server"
       Project = "Final Project"
    }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.Ubuntu2004.id
}