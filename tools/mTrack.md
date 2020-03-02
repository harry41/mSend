#### What is mTrack ?
mTrack is small script to track user Activities on linux system. We can monitor all user what commands they are executing on linux system.

#### How To Install/Setup mTrack Script on ubuntu.
We can install this script script on any of debian system.

##### Step 1: Install Script.
```bash
sudo curl -sL "https://github.com/harry41/mSend/raw/master/tools/mTrack.sh" -o /etc/profile.d/mTrack.sh
```

##### Step 2: Update SLACK_CLI_TOKEN and SLACK_CHANNEL To get notification on Slack Channel Group.

Edit `/etc/profile.d/mTrack.sh` file and update SLACK_CLI_TOKEN and SLACK_CHANNEL variable.

```bash
sudo vim /etc/profile.d/mTrack.sh
```

```bash
#update below variables
export SLACK_CLI_TOKEN='xoxb-xxxxxxxxxxx-xxxxxxxxx-xxxxxxxxxxxxxxxxx'
export SLACK_CHANNEL="#devops"
```
Create Slack Bot for your Applications : https://slack.com/intl/en-in/help/articles/115005265703-Create-a-bot-for-your-workspace
