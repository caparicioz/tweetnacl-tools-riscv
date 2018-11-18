#!/bin/bash
if [ -e sandbox/a.pub ] 
then
    truncate -s 0 sandbox/a.pub
else
    touch sandbox/a.pub
fi

if [ -e sandbox/a.sec ] 
then
    truncate -s 0 sandbox/a.sec
else
    touch sandbox/a.sec
fi

if [ -e sandbox/b.pub ] 
then
    truncate -s 0 sandbox/b.pub
else
    touch sandbox/b.pub
fi

if [ -e sandbox/b.sec ] 
then
    truncate -s 0 sandbox/b.sec
else
    touch sandbox/b.sec
fi

if [ -e sandbox/LordOfTheRings_encrypted.txt ] 
then
    truncate -s 0 sandbox/LordOfTheRings_encrypted.txt
else
    touch sandbox/LordOfTheRings_encrypted.txt
fi

if [ -d bin ] 
then
    rm -rf histogram
    mkdir histogram
    spike pk bin/tweetnacl-keypair sandbox/a.pub sandbox/a.sec
    spike pk bin/tweetnacl-keypair sandbox/b.pub sandbox/b.sec
    date
    spike -g pk bin/tweetnacl-encrypt sandbox/a.sec sandbox/b.pub ../input_files/LordOfTheRings.txt sandbox/LordOfTheRings_encrypted.txt > tweetnacl-encrypt_LordOfTheRings.out 2> histogram/tweetnacl-encrypt_LordOfTheRings.his
    date
    sort -k 2 -n histogram/tweetnacl-encrypt_LordOfTheRings.his > histogram/tweetnacl-encrypt_LordOfTheRings_sort.his 
else
    echo "Run make"
fi

