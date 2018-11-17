#!/bin/bash
if [ -e sandbox/a.pub ] 
then
    rm sandbox/a.pub
fi

if [ -e sandbox/a.sec ] 
then
    rm sandbox/a.sec
fi

if [ -e sandbox/b.pub ] 
then
    rm sandbox/b.pub
fi

if [ -e sandbox/b.sec ] 
then
    rm sandbox/b.sec
fi

if [ -e sandbox/LordOfTheRings_encrypted.txt ] 
then
    rm sandbox/LordOfTheRings_encrypted.txt
fi

if [ -d bin ] 
then
    ./bin/tweetnacl-keypair sandbox/a.pub sandbox/a.sec
    ./bin/tweetnacl-keypair sandbox/b.pub sandbox/b.sec
    date
    ./bin/tweetnacl-encrypt sandbox/a.sec sandbox/b.pub ../input_files/LordOfTheRings.txt sandbox/LordOfTheRings_encrypted.txt
    date 
else
    echo "Run make"
fi

