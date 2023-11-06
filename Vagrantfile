Vagrant.configure("2") do |config|

   # Configuração da primeira máquina virtual como bridge
   config.vm.define "vm1" do |vm1|
    vm1.vm.box = "ubuntu/focal64"
    vm1.vm.network "public_network", bridge: "enp0s3"
    vm1.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install tcpdump
      sudo tcpdump -i enp0s3 -w captura.pcap
      sudo apt-get install -y traceroute
    SHELL
  end

  config.vm.define :web do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.network :private_network, ip: "192.168.50.5"
    web.vm.hostname = "web"
    web.vm.provision :shell, path: "web.sh"
    
  end

  config.vm.define :db do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.network :private_network, ip: "192.168.60.5"
    db.vm.hostname = "db"
    db.vm.provision :shell, path: "db.sh"
  end
end


#a VM ‘web’ terá o endereço IP 10.0.0.10 e a VM ‘db’ terá o endereço IP 10.0.0.11
# Você pode acessar cada VM pelo seu respectivo endereço IP a partir de qualquer outra VM