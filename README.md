# FinalProject

<br>Notes for successfull deployment HTML/SampePage.php</br>

1) Fork the repository.

2) Create file ANSIBLE/DOCKER/aws_credentials.env with AWS credentials with such a look:
<br>![AWS_cred](https://github.com/marinaimeninnik/FinalProject/blob/main/pictures/Screenshot%20from%202023-02-20%2011-10-52.png)</br>

3) In main directory execute next commands:
$ vagrant init
$ vagrant up
Vagrant will up local virtual instance with docker dontainer with Jenkins in it

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

<br>Webhook configuration</br>
To translate localhost:8080 into web-address ngrok app used.

Setup:
<br>$ curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok </br>

Execute:
<br>$ ngrok http 8080</br>

<br>Pipeline build-infrastructure configuration:</br>

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

<br>Pipeline deploying-code first configuration:</br>

<br>Jenkins credentials creation:</br>

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
