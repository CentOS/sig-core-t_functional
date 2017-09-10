# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
  end

  config.vm.provider "libvirt" do |lv|
     lv.memory = "1024"
  end


  config.vm.define "target_c7" do |target_c7|
    target_c7.vm.box = "centos/7"
  end

  config.vm.define "target_c6" do |target_c6|
    target_c6.vm.box = "centos/6"
  end

  #C5 is EOL
  #config.vm.define "target_c5" do |target_c5|
  #  target_c5.vm.box = "centos/5"
  #end

  config.vm.provision "shell", inline: <<-SHELL
     yum -y update
     yum -y install vim-enhanced emacs-nox nano 
  SHELL

end
