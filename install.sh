#!/usr/bin/env bash

mSendBin=$(command -v msend)
mSysMonBin=$(command -v msysmon)

if [[ -z ${mSendBin} ]]; then
  sudo curl -sL "https://github.com/harry41/mSend/raw/master/msend" -o /usr/bin/msend
  sudo chmod +x /usr/bin/msend
  msend -v
fi

if [[ -z ${mSysMonBin} ]]; then
  sudo curl -sL "https://github.com/harry41/mSend/raw/master/tools/msysmon" -o /usr/bin/msysmon
  sudo chmod +x /usr/bin/msysmon
fi

source ~/.mSend/msend.conf

if [[ ${#EMAIL_SENDER_LIST[@]} -lt '1' ]]; then
  msend --get-smtp-auth
fi


# Step - 1 :  Generate HTML System Report
  msysmon

# Step - 2 :  Send Your Generated html reports to your email
  msend -t "your_email@domain.com" -s "${HOSTNAME}|$(date +%F)| System Health Report" -f /tmp/health_reports/report_$(date +"%d_%b_%y")_${HOSTNAME}.html -a /your/log/file.zip
