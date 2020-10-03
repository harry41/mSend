# TrackSSL Version
 **Version**        : {RELEASE_VER} <br>
 **Release Date**   : {RELEASE_DATE} <br>

# Welcome to TrackSSL!

 **TrackSSL** is a script to monitor **SSL** . it allow you to send email notification when your  **SSL** is about to expire. it will remind you to renew your ssl on time.


# Getting Start
![enter image description here](https://1.bp.blogspot.com/-V-xzii5P5kE/XxOvDqQTryI/AAAAAAAAAhc/MYPoxjTilskqgffR94m7Wd7S69eAVKrPgCLcBGAsYHQ/s1600/Expiration-Feature.png)

It will help you to monitor bulk domain's ssl. it required internet access to fetch certificate details .

## Prerequisite :
* You Must install **mSend** before installing TrackSSL.
mSend - [Install and configure smtp.](https://github.com/harry41/mSend)


## Installation

```bash
sudo curl -sL 'https://raw.githubusercontent.com/HarryTheDevOpsGuy/ssl-cert-check/master/ssl-cert-check' -o /usr/bin/trackssl
sudo chmod +x /usr/bin/trackssl
```

## Help

    trackssl -h

    Usage: /usr/bin/trackssl [ -e email address ] [-E sender email address] [ -x days ] [-q] [-a] [-b] [-h] [-i] [-n] [-N] [-v]
           { [ -s common_name ] && [ -p port] } || { [ -f cert_file ] } || { [ -c cert file ] } || { [ -d cert dir ] }

      -a                : Send a warning message through E-mail
      -b                : Will not print header
      -c cert file      : Print the expiration date for the PEM or PKCS12 formatted certificate in cert file
      -d cert directory : Print the expiration date for the PEM or PKCS12 formatted certificates in cert directory
      -e E-mail address : E-mail address to send expiration notices
      -E E-mail sender  : E-mail address of the sender
      -f cert file      : File with a list of FQDNs and ports
      -h                : Print this screen
      -i                : Print the issuer of the certificate
      -k password       : PKCS12 file password
      -n                : Run as a Nagios plugin
      -N                : Run as a Nagios plugin and output one line summary (implies -n, requires -f or -d)
      -p port           : Port to connect to (interactive mode)
      -q                : Don\'t print anything on the console
      -s commmon name   : Server to connect to (interactive mode)
      -S                : Print validation information
      -t type           : Specify the certificate type
      -V                : Print version information
      -x days           : Certificate expiration interval (eg. if cert_date < days)


## Check your SSL Expiry Date

```bash
trackssl -s google.com -p 443
```


## Send email notification if ssl expiry date less than 60 days.
```bash
trackssl -s google.com -p 443 -aq -x 60 -e yourmail@domain.com
```
  * It will trigger email if SSL expiry less then `60 days`

## Bulk Domain check and send email notification.

Create a file  `domain.txt` and paste below domain list in this file.
```bash
google.com 443
facebook.com 443
yahoo.com 443
flipkart.com 443
```
```bash
trackssl -f domain.txt -aq -x 40 -e youremail@domain.com
```
* it will send email notification if any domains expiry date less than 40 days from list.

## Configure Cronjobs To Get email alert daily or weekly.
You can schedule cronjob according to your choice. Here is few example for you. you can use any of one.

	# Schedule cron every monday and thursday at 9:00 am
	0 9 * * 1,4 /usr/bin/trackssl -f /opt/domain.txt -aq -x 40 -e youremail@domain.com

	# Schedule cron weekly
	@weekly /usr/bin/trackssl -f /opt/domain.txt -aq -x 40 -e youremail@domain.com

	# Schedule cron Daily
	@daily /usr/bin/trackssl -f /opt/domain.txt -aq -x 40 -e youremail@domain.com
