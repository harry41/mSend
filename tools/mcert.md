# mCert Version
 **Version**        : {RELEASE_VER} <br>
 **Release Date**   : {RELEASE_DATE} <br>


#### What is mCert ?
mCert is small script to notify before ssl expiration. it will help you to renew your ssl before getting expired.

#### Mode of alert Notification
There are two notificate methods are available. you can use both or any one.
  - Email Notification
  - Slack Notification

#### Prerequisite
if you want get notification on your email you must need to install mSlack. if you want to get slack notification you must need to install mSlack accordingly. or you can install and configure both if you wish to get notification on both.

 - mSend - To get email notification - [Installation steps](https://github.com/harry41/mSend)
 - mSlack - To get slack notification - It will install automatically.


##### Step 1: Install mCert.
```bash
sudo curl -sL "https://github.com/harry41/mSend/raw/master/tools/mcert" -o /usr/bin/mcert
sudo chmod +x /usr/bin/mcert

# Verify installation
mcert -v
```

#### Getting Start with help


```bash
## mcert -h

mCert [OPTION]
-d domain_name   Domain to test ssl expiration
-x days          Certificate expiration interval (eg. if cert_date days)
-f domain_file   File with a list of FQDNs|domains
-a email         Send Email Notification (Combine Report).
-e email         Send Email Notification
-s #devops       Send Slack Notification
-q               Don't print anything on the console
-b               Display header on the console
-r               Attach full csv report with combine report
-V               enable verbose
-h               Display this help
-v               Display version
```

#### example 1
To Test `www.google.com` ssl certificate if certificate expiry remaining day less than 60 day. it will send email notification at `your_email@domain.com`.

```bash
mcert -d www.google.com -e your_email@domain.com -x 60 -V
```
* `-x 60` check certificate expiration days.
* `-V`  enable verbose mode

#### example 2

if you want to test multiple domains you can run below command. it will send email and slack notification if any domain is going to expire within 60 days.

```bash
mcert -d "www.google.com facebook.com" -s "#devops" -e "your_email@domain.com" -x 60 -V
```
#### example 3

if you want to test multiple domains you can run below command. it will send email and slack notification if any domain is going to expire within 60 days.

Here you can create list of domains in txt file.

```bash
#cat /opt/domains.txt
www.google.com
www.facebook.com
www.apple.com
```


```bash
mcert -f "/opt/domains.txt" -s "#devops" -e "your_email@domain.com" -x 60 -V
```
* `-f` - to provide domain list file path.
