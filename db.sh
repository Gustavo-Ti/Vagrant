#!/bin/bash

sudo apt-get update
sudo apt-get install tcpdump
sudo apt-get install -y traceroute
sudo route add -net 192.168.60.0 netmask 255.255.255.0 gw 192.168.60.1

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

# Instalação e configuração do MySQL Server 
sudo apt-get install mysql-server -y

# Configuração do AppArmor para o MySQL Server 
sudo apt-get install apparmor-utils -y 
sudo aa-enforce /usr/sbin/mysqld 

# Remoção de pacotes desnecessários 
sudo apt-get autoremove -y 

# Configuração de auditoria e monitoramento com auditd 
sudo apt-get install auditd -y 

# ...

# Configuração segura do MySQL
sudo mysql_secure_installation

# Configuração para limitar conexões simultâneas
echo "[mysqld]
max_connections = 100" | sudo tee /etc/mysql/conf.d/limit_connections.cnf > /dev/null
