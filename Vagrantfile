Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004"

  config.vm.network "public_network", ip: "192.168.0.101"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

 # Run Ansible from the Vagrant Host

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ANSIBLE/install_docker_plbook.yaml" #docker, docker-compose installation
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ANSIBLE/docker_compose_plbook.yaml" #launch jenkins in docker container
  end

  # config.vm.provision "ansible" do |ansible|
  #   ansible.playbook = "ANSIBLE/creating_jenkins_user.yaml" #creates jenkins user
  # end

  # config.vm.provision "ansible" do |ansible|
  #   ansible.playbook = "ANSIBLE/install_terraform_plbook.yaml" #creates jenkins user
  # end

end