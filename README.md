# mSend
mSend is tiny utility to send unlimited email.

### How To Install mSend ?

```
wget https://raw.githubusercontent.com/harry41/mSend/master/msend && chmod +x msend
```

#### Lets Explore about More features

###### To view Help
   ```bash
   ./msend -h
   ```
###### To Send Email
   ```bash
   ./msend -t "youremail@domain.com" -s "Your Subject Here" -f "Email/Template/path.txt"
   ```
### How To Generate SMTP AUTH TOKEN ?
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

  ###### Troubleshooting  

  if you configured your smtp credentials and stil you are unable to send email.

  1. Go to your [Google Account](https://myaccount.google.com/)
  2. On the left navigation panel, click Security.
  3. On the bottom of the page, in the Less secure app access panel, click Turn on access.


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


#### About us
* Utility Name : mSend
* Developed by : Harry
* Email : HarryTheDevOpsGuy@gmail.com
