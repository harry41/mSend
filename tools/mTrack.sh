#!/bin/bash

################################################################################
#                      mTrack - Powered by M!TE                                #
#                                                                              #
# This script used to monitor user activities. It allow you to track all       #
# command line activities of all linux users.                                  #
#                                                                              #
# Change History                                                               #
# 11/11/2019  David Both    Original code. This is a template for creating     #
#                           new Bash shell scripts.                            #
#                           Add new history entries as needed.                 #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
#                                                                              #
#  Copyright (C) 2019, 2020 Harry The DevOps Guy                               #
#  harrythedevopsguy@gmail.com                                                 #
#  harrythedevopsguy.github.io                                                 #
#                                                                              #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 2 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program; if not, write to the Free Software                 #
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   #
#                                                                              #
################################################################################
################################################################################
################################################################################
export SLACK_CLI_TOKEN='xoxb-xxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxx-xxxxxxxxxxxx'
export SLACK_CHANNEL="#devops"
#export ADMIN_EMAIL="youremail@domain.com"
#Replace above variable Value according to your token and slack_channel name.
# Save This script in /etc/profile.d/mTrack.sh



PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
RED='\033[0;31m'
GREEN='\e[92m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
GREEN_BG='\e[42m'
GREEN_BOLT='\e[1;32m'
LIGHTGREEN_BOLT='\e[1;92m'
NC='\033[0m' # No Color
SLACK_BIN="/usr/bin/mslack"


install_dependency(){

  if [[ ! -f ${SLACK_BIN}  ]]; then
    echo "Installing mSlack Notifer and jq"
    sudo curl -s -L "https://raw.githubusercontent.com/rockymadden/slack-cli/master/src/slack" -o ${SLACK_BIN}
    sudo chmod +x ${SLACK_BIN}
    sudo apt-get install -y jq
  fi
}

load_vars(){

  if [[ -z ${MODE} ]]; then
    export MODE="auth"
  fi

  if [[ -z ${HISTTIMEFORMAT} ]]; then
    export HISTTIMEFORMAT="%F %T - "
  fi


  if [[ -z ${SLACK_CHANNEL} ]]; then
    echo -e "${YELLOW} Please define variable ${NC} export SLACK_CHANNEL='#yourchannelname'"
    exit 1
  fi

  if [[ -z ${SLACK_CLI_TOKEN} ]]; then
    echo -e "${YELLOW} Undefined variable ${NC} export SLACK_CLI_TOKEN=''xoxb-xxxxxxxxxxxxxxxxxxxxxx**your_slack_token'"
    exit 1
  fi

  token_char_count=$(echo "${SLACK_CLI_TOKEN}"|wc -c)

  if [[ "${SLACK_CLI_TOKEN:0:4}" != "xoxb" && ${token_char_count} != 56 ]]; then
    echo -e "${RED} Invalid Slack CLI Token ${NC} ${SLACK_CLI_TOKEN}"
    exit 1
  fi

}


get_server_info(){
  export PRIVATE_IP=$(hostname -I)
  export PUB_IP=$(curl -s icanhazip.com)
  export TIMESTAMP=$(date)
}

get_user_data(){
  log_path=/tmp/uinfo.log
  get_server_info

  echo "
A SSH login was successful, so here are some information for security:
    User           :  $USER
    User IP Host   :  ${SSH_CLIENT/ *}
    Date           :  ${TIMESTAMP}
    Hostname       :  `hostname`
    Server IP      :  ${PUB_IP} | ${PRIVATE_IP}

    We will notify you once user[$USER] will end session.
  " > ${log_path}

  if [[ -f "${log_path}" ]]; then
    cat ${log_path} | ${SLACK_BIN} chat send --channel "${SLACK_CHANNEL}" \
      --title "SSH login successful - ${USER}@${PRIVATE_IP} on ${TIMESTAMP}" \
      --color good > /dev/null 2>&1

    rm -f ${log_path}
  fi
}


get_cmd_history(){

  get_server_info

  export LH=$(tail ~/.bash_history|grep "#"|tail -n1)
  export HISTFILE=~/.bash_history
  set -o history
  history -a

if [[ ! -z ${LH} ]]; then
  grep -a -A400  "${LH}" ~/.bash_history| awk -F \\n '{ if ($0 ~ /^#[0-9]+/) {printf "%5d  %s ", ++i, strftime("%T", substr($1,2)); getline; print $0 }}' | \
    ${SLACK_BIN} chat send --channel "${SLACK_CHANNEL}" \
    --title "User Activities - ${USER}@${PRIVATE_IP} on ${TIMESTAMP}" \
    --pretext "\`${USER}\` has executed below commands on \`${USER}@${PRIVATE_IP} | ${PUB_IP}\`" \
    --color good > /dev/null 2>&1
  # else
  #   echo "unable to find last timestamp"
fi

# echo -e "${GREEN} Thank you for using. ${NC} All Activities has been monitored and sent to admin"
}








while getopts 'c:hm:t:' OPTION; do
  case "$OPTION" in
    c)
      export SLACK_CHANNEL="$OPTARG"
      ;;

    h)
      echo "h stands for h"
      ;;

    t)
      export SLACK_CLI_TOKEN="$OPTARG"
      ;;
    m)
      export MODE="$OPTARG"
      ;;
    ?)
      echo "script usage: $(basename $0) [-c #slack_channel] [-h] [-t slack_token] [-m auth|track]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
install_dependency > /dev/null 2>&1
load_vars

case ${MODE} in
  auth )
    get_user_data > /dev/null 2>&1
    # trap "get_cmd_history > /dev/null 2>&1" 0
    trap "get_cmd_history" 0
    ;;
  track )
    get_cmd_history
    ;;
  * )
    echo -e "${RED} Invalid agrs! ${NC} -m ${MODE}"
    exit 1
    ;;
esac
