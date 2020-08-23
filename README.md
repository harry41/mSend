# mSend
 **Version**        : v0.3.1 <br>
 **Release Date**   : 23-Aug-20 <br>
mSend is tiny utility to send unlimited email.


### Getting Start

##### Step - 1 Installation
```
sudo curl -L "https://github.com/harry41/mSend/raw/v0.3.1/msend" -o /usr/bin/msend
sudo chmod +x /usr/bin/msend
msend -h
```

![Alt text](https://2.bp.blogspot.com/-lxEU7HEk0PA/XHE_dAaGTiI/AAAAAAAAAaY/ZXtQrhu_Ksw4WGLbOzS1feORpRz6NiCMACLcBGAs/s1600/msend_help.png)

##### Step - 2 : Generate SMTP Auth Token
 **mSend** uses your gmail smtp login credentials to sent email. so you need to generate your smtp auth token by executing below command.

 ```bash
 ./msend --get-smtp-auth
 ```
 Output :
 ```bash
   Please Enter Valid Credentials  
   Enter Your Gmail ID : your_email@gmail.com
   Enter Your Gmail PASSWORD : secret@password
   Enter Email Sender Name : Harry

   Your SMTP AUTH TOKEN has been Saved in  ~/.mSend/msend.conf
 ```

##### Step - 3 : Enable Less Secure Application

1. Go to your [Google Account](https://myaccount.google.com/)
2. On the left navigation panel, click Security.
3. On the bottom of the page, in the Less secure app access panel, click Turn on access.

##### Step - 4 : Send test email.
You can create your own html templates. send your email by executing below commmand. Here we have created a html email template for you `~/.mSend/email_template.html`

```bash
msend -t your_email@domain.com -s "mSend Has been Installed" -f ~/.mSend/email_template.html -a /var/log/nginx/error.log
```

---
### Troubleshooting  
---

### How To Configure SMTP credentials in mSend ?

 Follow below step to configure SMTP
1. Go To `~/.mSend` Directory.
2. Open `msend.conf` file in your text editor.
3. Update variables value according to your details.
4. Done.

Here is sample msend.conf
```bash
# Replace below variables and uncomment according to your credentials and details.

# EMAIL_SENDER_LIST=("your_smtp_auth_token" "your_smtp_auth_token2")
# SENDER_NAME="Harry"
# REPLY_EMAIL_ADDRESS="Harry <HarryTheDevOpsGuy@gmail.com>
```
1. You can add multiple smtp credentials in `EMAIL_SENDER_LIST` variable.
2. `REPLY_EMAIL_ADDRESS` is very important recipient will reply on this email id.



### How To update mSend ?
 No Need to worry about updatation. it will update automatically every 30 days. also you can update anytime if it is required.

  **Run below command to Update**
  ```bash
  msend --update
  ```

#### About us
* **Utility Name** : [mSend](https://github.com/harry41/mSend)
* **Developed by** : [Harry](http://harry-thedevopsguy.blogspot.com/)
* **Email** : HarryTheDevOpsGuy@gmail.com
* **Sponsored by** : [eSpoir Soft pvt Ltd](http://espoirsoft.com)

#### Contributors
  - Shankar
  - Kapil
  - Chandan Bisht
  - Satya

**Thank you** So much for your contribution.
