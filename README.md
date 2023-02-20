# FinalProject

Notes for successfull deployment HTML/SampePage.php

1) Fork the repository.

2) Create file ANSIBLE/DOCKER/aws_credentials.env with AWS credentials with such a look:
<br>![AWS_cred](https://github.com/marinaimeninnik/FinalProject/blob/main/pictures/Screenshot%20from%202023-02-20%2011-10-52.png)</br>

3) In main directory execute next commands: 
$ vagrant init 
$ vagrant up
Vagrant will up local virtual instance with docker dontainer eith Jenkins in it

4) JEKINS pipeline should be created  manually with such configurations:

Plugins that shoud be installed:
- SSH Agent
- SSH Pipeline steps

Pipeline terraform-installation configuration:

Definition - Pipeline script from SCM
SCM - Git
Repository URL - https://github.com/marinaimeninnik/FinalProject.git
Branch specifier - */main
Script path - JENKINS/terraform-install

Webhook
To translate localhost:8080 into web-address ngrok used.
Setup:
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok 
Execute:
$ ngrok http 8080

Pipeline build-infrastructure configuration:

This project is parameterizes - true:
    Name - action
    Choises - apply
              destroy
    Description - What do you want to do with terraform APPLY or DESTROY?

Definition - Pipeline script from SCM
SCM - Git
Repository URL - https://github.com/marinaimeninnik/FinalProject.git
Branch specifier - */main
Script path - JENKINS/build-infrastructure

Pipeline deploying-code first configuration:

Create Jenkins credentials:
on EC2 instance:
in .ssh directory --> $ ssh-keygen
$ cat id_rsa.pub > authorized_keys
$ cat id_rsa --> input this key into jenkins credentials
use user "ubuntu" for ubuntu instance
    user "ec2-user" for Amazon Linux 2 instance

change ip in code onto actual public ip adress

Definition - Pipeline script from SCM
SCM - Git
Repository URL - https://github.com/marinaimeninnik/FinalProject.git
Branch specifier - */main
Script path - JENKINS/deploying-code
