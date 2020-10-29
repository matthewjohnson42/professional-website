# Scripts

Assumes that `initializeServer.sh` has been run on the system first.

Following that, `newCert.sh` can be run to create a SSL/TLS cert that will allow for verified SSL/TLS communications.

To update from github, run `updateSiteFromSource.sh`.

To renew the cert:

1) run `sudo certbot certonly --force-renewal -d matthewjohnson42.com`
2) select 3 for the method of verification, and enter `/usr/share/nginx/html/` as the webroot.
3) copy the DH random prime file from the previous certificate installation in `/etc/letsencrypt/live/`
4) update the nginx configuration in `/etc/nginx/sites-available` to reference the new certificate installation
5) reload nginx using `sudo nginx -s reload`, updating `run/nginx.pid` as appropriate
