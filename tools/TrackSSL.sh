
HOSTLIST="${1}"
SEND_EMAIL="${2:-mr.harry41@gmail.com}"


TRACKSSL=$(command -v trackssl)
if [[ -f ${TRACKSSL} ]]; then

  echo "${TRACKSSL} -a -f ~/domain.txt -q -x 60 -e ${SEND_EMAIL}"
#${TRACKSSL} -a -f ~/domain.txt -q -x 60 -e ${SEND_EMAIL}
# echo "${TRACKSSL} -aq -s facebook.com -p 443 -x 60 -e ${SEND_EMAIL}"
# ${TRACKSSL} -aq -s facebook.com -p 443 -x 60 -e ${SEND_EMAIL}

else
  echo "Installing ssl Tracker Script"
  sudo curl -sL 'https://raw.githubusercontent.com/HarryTheDevOpsGuy/ssl-cert-check/master/ssl-cert-check' -o /usr/bin/trackssl
  sudo chmod +x /usr/bin/trackssl

  echo "facebook.com 443
yahoo.com 443
google.com 443
harrythedevopsguy.github.io 443
  " > ~/domain.txt
fi
