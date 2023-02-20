# FinalProject

<br>Notes for successfull deployment HTML/SampePage.php</br>

1) Fork the repository.

2) Create file ANSIBLE/DOCKER/aws_credentials.env with AWS credentials with such a look:
<br>![AWS_cred](https://github.com/marinaimeninnik/FinalProject/blob/main/pictures/Screenshot%20from%202023-02-20%2011-10-52.png)</br>

<br>3) In main directory execute next commands:
$ vagrant init
$ vagrant up
Vagrant will up local virtual instance with docker dontainer eith Jenkins in it</br>

<br>4) JEKINS pipeline should be created  manually with such configurations:</br>

<br>Plugins that shoud be installed:</br>
<br>- SSH Agent</r>
<br>- SSH Pipeline steps</br>

<br>Pipeline terraform-installation configuration:</br>
<br>Definition - Pipeline script from SCM</br>
<br>SCM - Git</br>
<br>Repository URL - https://github.com/marinaimeninnik/FinalProject.git</br>
<br>Branch specifier - */main</br>
<br>Script path - JENKINS/terraform-install</br>

<br>Webhook configuration</br>
<br>To translate localhost:8080 into web-address ngrok used.</br>
<br>Setup:</br>
<br>$ curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok </br>
<br>Execute:</br>
<br>$ ngrok http 8080</br>

<br>Pipeline build-infrastructure configuration:</br>

<br>This project is parameterizes - true:
    Name - action
    Choises - apply
              destroy
    Description - What do you want to do with terraform APPLY or DESTROY?</br>

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
