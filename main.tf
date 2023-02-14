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

resource "aws_security_group" "final-project" {
  name        = "final-project"
  description = "Used in the terraform"
  # vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound internet access
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the internet
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.Ubuntu2004.id
}

output "instance_ip_addr" {
  value       = aws_instance.Ubuntu2004.public_ip
  description = "The private IP address of the main server instance."

  depends_on = [
    # Security group rule must be created before this IP address could
    # actually be used, otherwise the services will be unreachable.
    aws_security_group.final-project,
    aws_eip.ip
  ]
}

resource "aws_instance" "Ubuntu2004" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.ubuntuFP.id}"

    vpc_security_group_ids = ["${aws_security_group.final-project.id}"]

    connection {
    host = "${aws_instance.Ubuntu2004.public_ip}"# The default username for our AMI
    user = "ubuntu"
    type = "ssh"
    private_key = "${file(var.private_key_path)}"
    # The connection will use the local SSH agent for authentication.
  }

  # install java, create dir
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install openjdk-8-jre-headless",
      "sudo apt update",
      "sudo apt-get -y install apache2",
    # "sudo mkdir /var/www/php/",
      # "sudo apt-get -y install mysql-server",
      # "sudo systemctl start mysql.service",
      # "git clone https://github.com/marinaimeninnik/FinalProject.git",
      # "sudo rm /var/www/html/index.html",
      # "sudo cp /home/ubuntu/FinalProject/HTML/index.php /var/www/html",
      # "sudo cp /home/ubuntu/FinalProject/HTML/127_0_0_1_1.sql /var/www/html",
      # "sudo cp /home/ubuntu/FinalProject/HTML/connect.php /var/www/html"

    #   "mkdir data",
    #   "cd data",
    #   "mkdir inbox",
    #   "cd ..",
    ]
  }

    tags = {
       Name = "Ubuntu Server"
       Project = "Final Project"
    }
}
