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

# EMAIL_SENDER_LIST=("gmail_password1:youremail_1@gmail.com" "gmail_password2:youemail_2l@gmail.com")
# SENDER_NAME="Harry"
# REPLY_EMAIL_ADDRESS="Harry <HarryTheDevOpsGuy@gmail.com>
```
1. You can add multiple smtp credentials in `EMAIL_SENDER_LIST` variable.
2. `REPLY_EMAIL_ADDRESS` is very important recipient will reply on this email id.


#### About us
* Utility Name : mSend
* Developed by : Harry
* Email : HarryTheDevOpsGuy@gmail.com
