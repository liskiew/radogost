#!/bin/bash
FILE_TO_ENCRYPT="$1"
# PUBLIC_KEY_FILE="./goodylabs-backup-public.pem"
PUBLIC_KEY_FILE="$2"
DT=`date -u +\%Y\%m\%dt\%H\%M\%S`
FILE_TO_ENCRYPT_OUT="$FILE_TO_ENCRYPT.enc"
PASSWD_FILE="$FILE_TO_ENCRYPT_OUT.key"
PASSWD_FILE_ENC="$PASSWD_FILE.enc"


# generate pass
openssl rand  128 > ${PASSWD_FILE}
# echo 'hello' > ${PASSWD_FILE}

# encode pass with public key
openssl rsautl -encrypt -inkey ${PUBLIC_KEY_FILE} -pubin -in ${PASSWD_FILE} -out ${PASSWD_FILE_ENC}


# encode file with generated pass
openssl aes-256-cbc -in ${FILE_TO_ENCRYPT} -out ${FILE_TO_ENCRYPT_OUT} -pass file:${PASSWD_FILE}

# remove plain text pass
rm ${PASSWD_FILE}

