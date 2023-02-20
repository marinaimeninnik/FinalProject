variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-1"
}
variable "private_key_path" {
  description = "Path to the SSH private key to be used for authentication"
  default = "~/.ssh/key_pair_aws_1_id_rsa"
}

variable public_key_path{
  description = "Path to the SSH public key to be used for authentication"
  default = "~/.ssh/key_pair_aws_1_id_rsa.pub"
}

resource "aws_key_pair" "ubuntuFP" {
  key_name   = "ubuntuFP"               # key pair name AWS
  public_key = "${file(var.public_key_path)}"
}