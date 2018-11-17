#!/bin/bash

files=( "tweetnacl-decrypt" "tweetnacl-encrypt" "tweetnacl-keypair" "tweetnacl-sign" "tweetnacl-sigpair" "tweetnacl-verify")


i=1
rm -rf dump
mkdir dump

for i in ${files[*]}; do
	echo $i

	if [ ! -e bin/$i ]
		then
   		echo "File doesn't exists"
    		exit -1

	elif [ -d bin ]
		then
     		riscv64-unknown-elf-objdump -dC bin/$i > dump/$i.dump

	else
		echo "exit 0"
	
	fi
	
done



