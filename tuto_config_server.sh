################ LIST OF COMMANDS TO CONFIG SERVER


# this file shouldnt be executed, used as a tutorial
echo 'Shouldnt be executed, used only as a tutorial'
exit 1

# ######################
# ====================== SECURITY 
# ######################
# /
	# Update global env
	apt-get update
	apt-get upgrade
# /
	# Update root pass
	passwd root
# /
	# Autorizations compil / installers only for root
	chmod o-x /usr/bin/gcc-4.1 
	chmod o-x /usr/bin/make    
	chmod o-x /usr/bin/apt-get
	chmod o-x /usr/bin/aptitude
	chmod o-x /usr/bin/dpkg
# /
	# Check shadow mode OK (encrypted pwd or hidden)
	cat /etc/passwd
	cat /etc/shadow

# ///////////
# ----------- Turn off telnet
# /
	# Check if telnet is running
	ps -ef | grep telnet
	# or check if port 23 is opened
	nmap -sT -O localhost
	# Turn off telnet service
	kill -9 {pid_of_telnet}
	# Remove boot call if existing
	rm /etc/init.d/telnet
	
# ///////////
# ----------- SSH Level : basic
# /
	# Set a custom ssh port
	vi /etc/ssh/ssh_config

	#-- Change port (xx: 1 up to 65386)
	# Port xx

	#-- Accept password for the beginning 
	# PasswordAuthentication yes

	#-- Default settings
	# RSAAuthentication yes
	# Protocol 2,1

# /
	# Take into account settings
	service ssh restart
	# or 
	/etc/init.d/ssh restart
	
# ///////////
# ----------- Fail2Ban
# /
	# Usage : 
	  # Fail2Ban is used to update firewall rules (iptables) to reject the IP addresses for a specified amount of time, 
	  # although any arbitrary other action (e.g. sending an email) could also be configured. 
	  # Out of the box Fail2Ban comes with filters for various services (apache, courier, ssh, etc).
	# Doc : http://www.fail2ban.org/wiki/index.php/Main_Page
	
	# install 
	apt-get install fail2ban
	
	# Global config file
	vi /etc/fail2ban/fail2ban.conf

	# Create your own config file
	# Fail2Ban will automatically use jail.local if existing
	cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# /
	# Take into account settings
	fail2ban-client reload
	# or 
	/etc/init.d/fail2ban restart
# /	
	# To check if jails are taken into account
	fail2ban-client status

	# To manage a specific jail, with commands: stop, start, status
	fail2ban-client status ssh
# /	
	# Jail config
	  # The DEFAULT section allows a global definition of the options. 
	  # They can be overridden in each jail afterwards.

	vi /etc/fail2ban/jail.local
	# content example
# @@
# @@ begin of example
[DEFAULT]
# "ignoreip" can be an IP address, a CIDR mask or a DNS host
# if several IP, seperate them by space
ignoreip = 127.0.0.1/8
# ban time (in seconds)
bantime  = 600
# nb of retries before ban
maxretry = 3
# sampled time to evaluate rule's violation (in seconds)
findtime = 600

# "backend" specifies the backend used to get files modification. Available
# options are "gamin", "polling" and "auto".
# NB:For some reason Debian shipped python-gamin didn't work as expected
#    This issue left ToDo, so polling is default backend for now
backend = auto
# Destination email address used solely for the interpolations in
# jail.{conf,local} configuration files.
destemail = mail_1@mail.com, mail_2@mail.com

# ACTIONS
# Default banning action (e.g. iptables, iptables-new,
# iptables-multiport, shorewall, etc) It is used to define
# action_* variables. Can be overridden globally or per
# section within jail.local file
banaction = iptables-multiport
# email action. Since 0.8.1 upstream fail2ban uses sendmail
# MTA for the mailing. Change mta configuration parameter to mail
# if you want to revert to conventional 'mail'.
mta = sendmail

# Default protocol
protocol = tcp

# Specify chain where jumps would need to be added in iptables-* actions
chain = INPUT

#
# Action shortcuts. To be used to define action parameter
# The simplest action to take: ban only
action_ = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
# ban & send an e-mail with whois report to the destemail.
action_mw = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
              %(mta)s-whois[name=%(__name__)s, dest="%(destemail)s", protocol="%(protocol)s", chain="%(chain)s"]
# ban & send an e-mail with whois report and relevant log lines
# to the destemail.
action_mwl = %(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
               %(mta)s-whois-lines[name=%(__name__)s, dest="%(destemail)s", logpath=%(logpath)s, chain="%(chain)s"]

# Choose default action.  To change, just override value of 'action' with the
# interpolation to the chosen action shortcut (e.g.  action_mw, action_mwl, etc) in jail.local
# globally (section [DEFAULT]) or per specific section
action = %(action_mwl)s
# @@ end of example
# @@
# /

	
	