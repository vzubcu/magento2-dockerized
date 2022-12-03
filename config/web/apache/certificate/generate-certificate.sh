#!/bin/sh
openssl req -x509 -nodes -newkey rsa:2048 \
-config ./openssl.cnf \
-keyout magentolts.local/privkey.pem \
-out magentolts.local/fullchain.pem \
-days 3600 \
-subj '/C=DE/ST=SN/L=Dresden/O=Neobit/OU=Neobit/CN=magentolts.local/emailAddress=dev@neobit.local'
