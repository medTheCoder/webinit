################ LIST OF COMMANDS TO CONFIG SERVER


# this file shouldnt be executed
echo 'Shouldnt be executed, used only as a tutorial'
exit 1

#=============== SECURITY 

# Update root pass
passwd root

# Update global env
apt-get update
apt-get upgrade

# Check shadow mode OK (encrypted pwd)
cat /etc/passwd
cat /etc/shadow

#--------------- SSH Level : basic
# Set a custom ssh port
vi /etc/ssh/ssh_config

#-- Change port (xx: 1 up to 65386)
# Port xx

#-- Accept password for the beginning 
# PasswordAuthentication yes

#-- Default settings
# RSAAuthentication yes
# Protocol 2,1


# Take into account settings
service ssh restart
# or 
/etc/init.d/ssh restart
