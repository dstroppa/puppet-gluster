# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Vagrant >1.1 config
  config.vm.box = "centos64"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"

  (1..1).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "gluster-node#{i}.test"
      node.vm.network :private_network, ip: "192.168.1.6#{i}"
      #node.vm.provision :shell, :inline => "sudo yum -y update"
      (0..1).each do |d|
        config.vm.provider "virtualbox" do |vb|
          vb.customize [ "createhd", "--filename", "disk-#{i}-#{d}", "--size", "5000" ]
          vb.customize [ "storageattach", :id, "--storagectl", "SATA Controller", "--port", 3+d, "--device", 0, "--type", "hdd", "--medium", "disk-#{i}-#{d}.vdi" ]
        end
      end

      node.vm.provision :shell, :inline => "ln -s /vagrant /etc/puppet/modules/gluster"
      node.vm.provision :shell, :inline => "puppet module install puppetlabs-stdlib"

      node.vm.provision :puppet do |puppet|
        puppet.manifests_path = "examples"
        puppet.manifest_file = "icclab-testbed.pp"
        puppet.options = ['--verbose', '--debug']
      end
    end
  end

  config.vm.define "node4" do |node|
    node.vm.hostname = "gluster-node4.test"
    node.vm.network :private_network, ip: "192.168.1.64"
    node.vm.provision :shell, :path => "examples/create_vip.sh"
    #node.vm.provision :shell, :inline => "sudo yum -y update"
    (0..1).each do |d|
      config.vm.provider "virtualbox" do |vb|
        vb.customize [ "createhd", "--filename", "disk-4-#{d}", "--size", "5000" ]
        vb.customize [ "storageattach", :id, "--storagectl", "SATA Controller", "--port", 3+d, "--device", 0, "--type", "hdd", "--medium", "disk-4-#{d}.vdi" ]
      end
    end

    node.vm.provision :shell, :inline => "ln -s /vagrant /etc/puppet/modules/gluster"
    node.vm.provision :shell, :inline => "puppet module install puppetlabs-stdlib"

    node.vm.provision :puppet do |puppet|
      puppet.manifests_path = "examples"
      puppet.manifest_file = "icclab-testbed.pp"
      puppet.options = ['--verbose', '--debug']
    end
  end



  config.vm.define "client" do |client|
    client.vm.hostname = "gluster-client.test"
    client.vm.network :private_network, ip: "192.168.1.100"
    #client.vm.provision :shell, :inline => "sudo yum -y update"

    client.vm.provision :shell, :inline => "ln -s /vagrant /etc/puppet/modules/gluster"
    client.vm.provision :shell, :inline => "puppet module install puppetlabs-stdlib"

    client.vm.provision :puppet do |puppet|
      puppet.manifests_path = "examples"
      puppet.manifest_file = "icclab-testbed-client.pp"
      puppet.options = ['--verbose']
    end
  end

end
