# FinalProject

JEKINS

Plugins that shoud be installed:
- SSH Agent
- SSH Pipeline steps

Pipeline terraform-infrastructure configuration:

Definition - Pipeline script from SCM
SCM - Git
Repository URL - https://github.com/marinaimeninnik/FinalProject.git
Branch specifier - */main
Script path - JENKINS/terraform-install

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

Webhook
To translate localhost:8080 into web-address ngrok used.
Setup:
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok 
Execute:
$ ngrok http 8080

