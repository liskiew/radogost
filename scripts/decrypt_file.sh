#!/bin/bash
FILE_TO_DECRYPT="$1"
# PUBLIC_KEY_FILE="./goodylabs-backup-public.pem"
PRIVATE_KEY_FILE="$2"
DT=`date -u +\%Y\%m\%dt\%H\%M\%S`
PASSWD_FILE_ENC="$FILE_TO_DECRYPT.key.enc"
PASSWD_FILE="$FILE_TO_DECRYPT.key"
FILE_TO_DECRYPT_OUT="$FILE_TO_DECRYPT.dec"



openssl rsautl -decrypt -inkey  $PRIVATE_KEY_FILE -in $PASSWD_FILE_ENC -out $PASSWD_FILE
openssl aes-256-cbc -d -in $FILE_TO_DECRYPT -pass file:$PASSWD_FILE -out $FILE_TO_DECRYPT_OUT

# remove plain text pass
rm ${PASSWD_FILE}

