# update git
echo
echo "--------------------------------"
echo "UPDATING NGINX FILES FROM SOURCE"
echo "--------------------------------"
echo

if [ -z ${PERSONAL_WEBSITE_HOME} ]; then
  export PERSONAL_WEBSITE_HOME=/home/ubuntu/personal-website
fi

if [ -z ${NGINX_HTTP_HOME_DIR} ]; then
  export NGINX_HTTP_HOME_DIR=/usr/share/nginx/html
fi

# allow outbound http requests
sudo sh ${PERSONAL_WEBSITE_HOME}/scripts/ufwAllowOut.sh

# update local git repo
cd ${PERSONAL_WEBSITE_HOME}
git fetch origin
git checkout origin/master
git branch -D master
git checkout master

# copy files to nginx server directory
sudo rm -rf /usr/share/nginx/html
sudo mkdir /usr/share/nginx/html
sudo cp ${PERSONAL_WEBSITE_HOME}/webpage/about.html ${NGINX_HTTP_HOME_DIR}/about.html
sudo cp ${PERSONAL_WEBSITE_HOME}/webpage/index.html ${NGINX_HTTP_HOME_DIR}/index.html
sudo cp -r ${PERSONAL_WEBSITE_HOME}/webpage/css/ ${NGINX_HTTP_HOME_DIR}/css/
sudo cp -r ${PERSONAL_WEBSITE_HOME}/webpage/images/ ${NGINX_HTTP_HOME_DIR}/images/
sudo cp -r ${PERSONAL_WEBSITE_HOME}/webpage/docs/ ${NGINX_HTTP_HOME_DIR}/docs/

# copy scripts to home directory for system maintenance
cp ${PERSONAL_WEBSITE_HOME}/scripts/updateSiteFromSource.sh ~

# restart nginx
sudo sh ${PERSONAL_WEBSITE_HOME}/scripts/nginxRestart.sh

# deny outbound http requests
sudo sh ${PERSONAL_WEBSITE_HOME}/scripts/ufwDenyOut.sh
