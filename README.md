# personal-website

My personal website as hosted on AWS Lightsail with DNS registration by Google.

Website's HTTP server is nginx installed on Ubuntu with certificates generated using [Certbot](https://certbot.eff.org/).

The domain that the website has a DNS "A" record in place for is [matthewjohnson42.com](https://matthewjohnson42.com).

Setup instructions:
1. Create a Lightsail instance, OS only, with Ubtuntu 18.08 LTS as the OS
2. Configure the instance to have port 443 open on the AWS firewall
3. Login to the instance via ssh
4. Run the following command to initialize the server with an Nginx install pointed at the website files; there will be prompts. Follow them to install TLS certificates to the instance for use by Nginx.
```
curl -o initializeServer.sh https://raw.githubusercontent.com/matthewjohnson42/personal-website/master/scripts/initializeServer.sh \
&& sh initializeServer.sh
```
5. Update DNS records to point to the IP of the Lightsail instance
6. Logout, wait for DNS records to propegate (wait lasts up to days)
