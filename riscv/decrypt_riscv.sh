#!/bin/bash
if [ ! -e sandbox/LordOfTheRings_encrypted.txt ]
then
    echo "Can't find encrypted file"
    exit -1
else
    truncate -s 0 sandbox/LordOfTheRings_decrypted.txt
fi
if [ -d bin ] 
then
    date
    spike pk bin/tweetnacl-decrypt sandbox/a.pub sandbox/b.sec sandbox/LordOfTheRings_encrypted.txt sandbox/LordOfTheRings_decrypted.txt 
    date 
else
    echo "Run make"
fi

