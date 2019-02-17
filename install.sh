#!/usr/bin/env bash

mSendBin=$(command -v msend)
mSysMonBin=$(command -v msysmon)
if [[ -z ${mSendBin} ]]; then
  echo "Installing mSend..."
  sudo curl -sL "https://github.com/harry41/mSend/raw/master/msend" -o /usr/bin/msend
  sudo chmod +x /usr/bin/msend
  msend -v
fi
if [[ -z ${mSysMonBin} ]]; then
  echo "Installing mSysMon..."
  sudo curl -sL "https://github.com/harry41/mSend/raw/master/tools/msysmon" -o /usr/bin/msysmon
  sudo chmod +x /usr/bin/msysmon
fi
[ ! -f ~/.mSend/msend.conf ] || source ~/.mSend/msend.conf
if [[ ${#EMAIL_SENDER_LIST[@]} -lt '1' ]]; then
  echo "Please enter your smtp Credentials (only Gmail ID valid)"
  msend --get-smtp-auth
fi


# Step - 1 :  Generate HTML System Report
  msysmon


# Step - 2 :  Send Your Generated html reports to your email
# User configs :
EMAIL_TO="HarryTheDevOpsGuy@gmail.com"  # replace HarryTheDevOpsGuy@gmail.com with your email id.
if [[ ! -z ${EMAIL_TO} && ${#EMAIL_SENDER_LIST[@]} -gt '0' ]]; then
  msend -t "${EMAIL_TO}" -s "${HOSTNAME}|$(date +%F)| System Health Report" -f /tmp/health_reports/report_$(date +"%d_%b_%y")_${HOSTNAME}.html -a /your/log/file.zip
fi

# How To configure this script

# Step - 1 :- Before executing this script you need to replace my email id [HarryTheDevOpsGuy@gmail.com] with your email.
# Step - 2 :- You may update subject -s accordingly.
# Step - 3 :- You may attach any file using -a.
# Step - 4 :- done.
