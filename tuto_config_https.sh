################ LIST OF COMMANDS TO CONFIG HTTPS


# this file shouldnt be executed
echo 'Shouldnt be executed, used only as a tutorial'
exit 1

# source : http://doc.ubuntu-fr.org/tutoriel/securiser_apache2_avec_ssl


# The following commands have to prefixed by sudo if logged as root

#### ssl module
# -- enable ssl module
a2enmod ssl

# -- reload apache
service apache2 force-reload
# -- or
/etc/init.d/apache2 force-reload

#### certificat ---------------
# -- install ssl-cert if missing
apt-get install ssl-cert

# -- create auto-signed certificate
make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/ssl/private/localhost.pem

# -x509 -nodes : type of certificate
# -newkey rsa:1024 : bigger value is not recommended for compatibility
# -keyout /etc/apache2/server.key : private key
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -out /etc/apache2/server.crt -keyout /etc/apache2/server.key


# -- if wanted a free cert without notification's browser
# go to startssl.com


#### config apache2  ---------- 

### enrich the current config

# -- add listener port
vi /etc/apache2/ports.conf
# -- add the listener
Listen 443

# -- redirect http tp https

<VirtualHost *:80>
    ServerName example.com/
    Redirect / https://example.com/
</VirtualHost>

# -- link to certificates
<VirtualHost *:443>
	ServerName example.com
	DocumentRoot /var/www/example.com

	SSLEngine on
	SSLCertificateFile /etc/apache2/server.crt
	SSLCertificateKeyFile /etc/apache2/server.key
</VirtualHost>

## -- reload apache
/etc/init.d/apache2 reload
