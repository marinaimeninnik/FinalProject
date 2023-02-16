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

data "aws_ami" "amazon-linux-2" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        # values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20230207"]
        # values = ["amazon/amzn2-ami-kernel-5.10-hvm-2.0.20230207.0-x86_64-gp2"]
        values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
    }
}

resource "aws_security_group" "final-project1" {
  name        = "final-project1"
  description = "Used in the terraform"
  # vpc_id      = "${aws_vpc.default.id}"
  lifecycle {
    create_before_destroy = true
  }

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
    instance = aws_instance.AmazonEC2.id
}

output "instance_ip_addr" {
  value       = aws_instance.AmazonEC2.public_ip
  description = "The private IP address of the main server instance."

  depends_on = [
    aws_security_group.final-project1,
    aws_eip.ip
  ]
}

resource "aws_instance" "AmazonEC2" {
    ami = data.aws_ami.amazon-linux-2.id
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.ubuntuFP.id}"

    vpc_security_group_ids = ["${aws_security_group.final-project1.id}"]

    connection {
    host = "${aws_instance.AmazonEC2.public_ip}"# The default username for our AMI
    user = "ec2-user"
    type = "ssh"
    private_key = "${file(var.private_key_path)}"
    # The connection will use the local SSH agent for authentication.
  }

  # install java, create dir
  provisioner "remote-exec" {
    inline = [

      //for amazon-2 linux instance,
      //installation Apache web server with PHP and MariaDB,

      "sudo yum update -y",
      "sudo amazon-linux-extras install php8.0 mariadb10.5 -y",
      "cat /etc/system-release",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",

      //configurations

      # "sudo usermod -a -G apache ec2-user",
      # "exit",
      # "groups",
      # "ec2-user adm wheel apache systemd-journal",
      # "sudo chown -R ec2-user:apache /var/www",
      # "sudo chmod 2775 /var/www",
      # "find /var/www -type d -exec sudo chmod 2775 {} \;"",
      # "find /var/www -type f -exec sudo chmod 0664 {} \;"",

      # // for ubuntu instnce

      # "sudo apt-get -y update",
      # "sudo apt-get -y install openjdk-8-jre-headless",
      # "sudo apt update",
      # "sudo apt-get -y install apache2",
    ]
  }

    tags = {
       Name = "Amazon Linux 2"
       Project = "Final Project"
    }
}
