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
    spike -g pk bin/tweetnacl-decrypt sandbox/a.pub sandbox/b.sec sandbox/LordOfTheRings_encrypted.txt sandbox/LordOfTheRings_decrypted.txt > tweetnacl-decrypt_LordOfTheRings.out 2> histogram/tweetnacl-decrypt_LordOfTheRings.his
    date
    sort -k 2 -n histogram/tweetnacl-decrypt_LordOfTheRings.his > histogram/tweetnacl-decrypt_LordOfTheRings_sort.his
     
else
    echo "Run make"
fi

