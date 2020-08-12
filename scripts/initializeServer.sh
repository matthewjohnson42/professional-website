# install nginx
echo
echo "----------------"
echo "INSATLLING NGINX"
echo "----------------"
echo
sudo apt-get --yes update
sudo apt-get --yes install nginx
echo

# clone source git repo
echo
echo "---------------------------"
echo "DOWNLOADING WEBSITE SOURCES"
echo "---------------------------"
echo
cd ~
rm -rf ~/personal-website
git clone https://github.com/matthewjohnson42/personal-website.git

# configure env vars for future use by scripts
echo
echo "--------------------"
echo "CONFIGURING ENV VARS"
echo "--------------------"
echo
export PERSONAL_WEBSITE_HOME=${HOME}/personal-website
echo "export PERSONAL_WEBSITE_HOME=${PERSONAL_WEBSITE_HOME}" >> ~/.bashrc
export NGINX_HTTP_HOME_DIR=/usr/share/nginx/html
echo "export NGINX_HTTP_HOME_DIR=${NGINX_HTTP_HOME_DIR}" >> ~/.bashrc

echo
echo "-----------------"
echo "CONFIGURING NGINX"
echo "-----------------"
echo
# copy files from source repo to nginx html directory
sudo rm -rf /usr/share/nginx/html
sudo mkdir /usr/share/nginx/html
sudo cp ${PERSONAL_WEBSITE_HOME}/about.html ${NGINX_HTTP_HOME_DIR}/about.html
sudo cp ${PERSONAL_WEBSITE_HOME}/index.html ${NGINX_HTTP_HOME_DIR}/index.html
sudo cp ${PERSONAL_WEBSITE_HOME}/favicon.ico ${NGINX_HTTP_HOME_DIR}/favicon.ico
sudo cp ${PERSONAL_WEBSITE_HOME}/style.css ${NGINX_HTTP_HOME_DIR}/style.css
sudo cp -r ${PERSONAL_WEBSITE_HOME}/images/ ${NGINX_HTTP_HOME_DIR}/images/
sudo cp -r ${PERSONAL_WEBSITE_HOME}/docs/ ${NGINX_HTTP_HOME_DIR}/docs/
# copy and link nginx configuration that specifies routing of http to the nginx html directory
sudo cp ~/personal-website/nginx/matthewjohnson42.com /etc/nginx/sites-available/
sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/matthewjohnson42.com /etc/nginx/sites-enabled/matthewjohnson42.com
# start nginx
sudo sh ${PERSONAL_WEBSITE_HOME}/scripts/nginxRestart.sh

# install a tls cert and configure nginx to use it
# https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-using-lets-encrypt-certificates-with-nginx
# https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx
echo
echo "------------------------------------"
echo "INSTALLING TLS CERTIFICATE FOR NGINX"
echo "------------------------------------"
echo
# install certbot
sudo apt-get update
sudo apt-get --yes install software-properties-common
sudo add-apt-repository --yes universe
sudo add-apt-repository --yes ppa:certbot/certbot
sudo apt-get update
sudo apt-get --yes install certbot python3-certbot-nginx
# generate DH random prime, certificate, and certificate private key
sudo certbot -d matthewjohnson42.com -d www.matthewjohnson42.com --manual --preferred-challenges dns certonly
sudo openssl dhparam -out /etc/letsencrypt/live/matthewjohnson42.com/dhparam.pem 2048
# copy and link nginx configuration that adds listening for https, adds redirection of http to https, specifies the
# prime/certificate/key to use for https connections
sudo cp ${PERSONAL_WEBSITE_HOME}/nginx/matthewjohnson42.com.tls /etc/nginx/sites-available/matthewjohnson42.com.tls
sudo rm -f /etc/nginx/sites-enabled/matthewjohnson42.com
sudo ln -s /etc/nginx/sites-available/matthewjohnson42.com.tls /etc/nginx/sites-enabled/matthewjohnson42.com
# restart nginx
sudo sh ${PERSONAL_WEBSITE_HOME}/scripts/nginxRestart.sh

# setup firewall
echo
echo "--------------------"
echo "CONFIGURING FIREWALL"
echo "--------------------"
echo
sudo ufw --force enable
sudo ufw deny out to any from any
sudo ufw allow in to any port 22 from any
sudo ufw allow in to any port 53 from any
sudo ufw allow in to any port 80 from any
sudo ufw allow in to any port 443 from any
sudo ufw deny in to any from any

# complete; list crontab record modification for automatic renewal of certs
echo
echo "--------"
echo "COMPLETE"
echo "--------"
echo
echo "Run \`crontab -e\` and enter the following record to set up auto renewal:"
echo
echo "0 23 * * * sudo /usr/bin/certbot renew --post-hook \"nginx -s reload\""
echo
echo
