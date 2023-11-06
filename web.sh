#!/bin/bash

    sudo apt-get update
    sudo apt-get install tcpdump
    sudo tcpdump -i enp0s3 -w traffic.pcap
    sudo apt-get install -y traceroute
    sudo route add -net 192.168.50.0 netmask 255.255.255.0 gw 192.168.50.1
# Atualização e upgrade do sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalação de atualizações de segurança automáticas
sudo apt-get install unattended-upgrades -y
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Instalação e configuração do UFW
sudo apt-get install ufw -y
sudo ufw allow ssh
sudo ufw enable

# Instalação e configuração do Fail2ban
sudo apt-get install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Desabilitar o login root
sudo passwd -l root

# Configuração de senhas fortes
echo "ubuntu ALL=(ALL) PASSWD: ALL" | sudo tee /etc/sudoers.d/passwd_policy

# Instalação e configuração do Apache
sudo apt-get install apache2 -y
sudo chown www-data:www-data /var/www/html/ -R

# Configuração do AppArmor para o Apache
sudo apt-get install apparmor-utils -y
sudo aa-enforce /usr/sbin/apache2

# Remoção de pacotes desnecessários
sudo apt-get autoremove -y

# Configuração de auditoria e monitoramento com auditd
sudo apt-get install auditd -y

# ...

# Instalação e configuração do ModSecurity
sudo apt-get install libapache2-mod-security2 -y
sudo mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
sudo sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf

# Instalação e configuração do ModEvasive
sudo apt-get install libapache2-mod-evasive -y
sudo mkdir /var/log/mod_evasive
sudo chown www-data:www-data /var/log/mod_evasive/
echo "<IfModule mod_evasive20.c>
DOSHashTableSize 3097
DOSPageCount 2
DOSSiteCount 50
DOSPageInterval 1
DOSSiteInterval 1
DOSBlockingPeriod 10
DOSLogDir /var/log/mod_evasive
</IfModule>" | sudo tee /etc/apache2/mods-enabled/evasive.conf > /dev/null
