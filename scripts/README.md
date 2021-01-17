# Scripts

## configure nginx on debian/ubuntu-based host

see `initalizeServer.sh`

## cert addition or renewal

Assumes that `initializeServer.sh` has been run on the system first.

To renew the cert:

1) run `sudo certbot certonly --force-renewal -d matthewjohnson42.com`
2) select 3 for the method of verification, and enter `/usr/share/nginx/html/` as the webroot.
3) copy the DH random prime file from the previous certificate installation in `/etc/letsencrypt/live/`
4) update the nginx configuration in `/etc/nginx/sites-available` to reference the new certificate installation
5) reload nginx using `sudo nginx -s reload`, updating `run/nginx.pid` as appropriate

## updating the remote host's content from GitHub

see `updateSiteFromSource.sh`.

## firewall configuration

Performed by the initial host/webserver configuration in `initalizeServer.sh`

see `ufwDenyOut.sh`
see `ufwAllowOut.sh`
