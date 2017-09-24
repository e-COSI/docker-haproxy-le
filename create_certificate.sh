#!/bin/bash
if [ $# -ne 1 ] ; then
echo "$(date +%c) Please give domain name as parameter"
exit 1
fi
echo "$(date +%c) Generate certificat for ${1}"
/opt/letsencrypt/letsencrypt-auto  certonly  --domains $1 --renew-by-default --http-01-port 63443 --agree-tos --preferred-challenges http-01 --non-interactive
if [ $? -eq 0 ]; then
    echo "$(date +%c) Success ! Now creating ${1}.pem"
    cat /etc/letsencrypt/live/$1/fullchain.pem /etc/letsencrypt/live/$1/privkey.pem > /etc/haproxy/cert/$1.pem
    systemctl reload haproxy
else
    echo "$(date +%c) Error creating certificate with error code $?, exit script..."
fi
exit 0
