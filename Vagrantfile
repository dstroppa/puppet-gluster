# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Vagrant >1.1 config
  config.vm.box = "f18"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210.box"

  (0..2).each do |i|
    config.vm.define "gluster-server#{i}" do |osd|
      osd.vm.hostname = "gluster-server#{i}.test"
      osd.vm.network :private_network, ip: "192.168.261.10#{i}"
      osd.vm.network :private_network, ip: "192.168.262.10#{i}"
      #osd.vm.provision :shell, :path => "examples/osd.sh"
      (0..0).each do |d|
        osd.vm.customize [ "createhd", "--filename", "disk-#{i}-#{d}", "--size", "5000" ]
        osd.vm.customize [ "storageattach", :id, "--storagectl", "SATAController", "--port", 3+d, "--device", 0, "--type", "hdd", "--medium", "disk-#{i}-#{d}.vdi" ]
      end
    end
  end

end
