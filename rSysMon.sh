#!/usr/bin/env bash
# Before executing this script. You need to install mSend and configure to send email.
# To Test :
# bash rSysMon.sh "dprod" "mr.harry41@gmail.com"

export msend_bin=$(which msend)
export REMOTE_HOST="${1:-127.0.0.1}"
export EMAIL_TO=${2:-HarryTheDevOpsGuy@gmail.com}

if [[ -z ${msend_bin} ]]; then
  echo "Please install mSend and configure."
  echo "Follow to Install : https://github.com/harry41/mSend"
  exit 1
fi
monitor(){
  # REMOTE_HOST="${1}"
  # EMAIL_TO=${2:-HarryTheDevOpsGuy@gmail.com}
  REPORT_NAME="ServerHealthReport"
  REPORT_FILE="/tmp/health_reports/${REPORT_NAME}.html"
  LOCAL_FILE="/tmp/${REPORT_NAME}.html"
  msysmon=$(ssh ${REMOTE_HOST} "which msysmon")

  if [[ ${msysmon} == "/usr/bin/msysmon" ]]; then
    ssh ${REMOTE_HOST} "msysmon '${REPORT_NAME}'"
    scp  ${REMOTE_HOST}:${REPORT_FILE} ${LOCAL_FILE}

    if [[ -f ${LOCAL_FILE} ]]; then
      grep 'SM_' ${LOCAL_FILE} > /tmp/remotevars
      source /tmp/remotevars
      ${msend_bin} -t "${EMAIL_TO}" -s "${SM_EMAIL_SUBJECT:- Server Health Report}" -f "${LOCAL_FILE}"
      rm -rf ${LOCAL_FILE} /tmp/remotevars
    fi
  else
    ssh ${REMOTE_HOST} "sudo curl -sL 'https://github.com/harry41/mSend/raw/master/tools/msysmon' -o /usr/bin/msysmon && sudo chmod +x /usr/bin/msysmon"
    ret_val=$?
    if [[ ${ret_val} != 0 ]]; then
      echo "Run Below command to install msysmon on remote server."
      echo "sudo curl -sL 'https://github.com/harry41/mSend/raw/master/tools/msysmon' -o /usr/bin/msysmon
      sudo chmod +x /usr/bin/msysmon"
    else
      echo "Please run again to Generate System Health Report"
    fi
  fi
}
if [[ -z ${REMOTE_HOST} || -z ${EMAIL_TO} ]]; then
  echo "Please pass valid hostname and email"
else
  echo "Please Wait.. : Connecting Remote host ${REMOTE_HOST}"
  monitor "${REMOTE_HOST}" "${EMAIL_TO}"
fi
