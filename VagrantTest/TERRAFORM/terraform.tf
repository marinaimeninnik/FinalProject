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


resource "aws_instance" "Ubuntu2004" {
    ami           = "ami-09cd747c78a9add63"
    instance_type = "t2.micro"

    tags = {
        Name = "Ubuntu Server"
        Project = "Final Project"
    }
}