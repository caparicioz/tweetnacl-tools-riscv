#!/bin/bash

files=( "tweetnacl-decrypt" "tweetnacl-encrypt" "tweetnacl-keypair" "tweetnacl-sign" "tweetnacl-sigpair" "tweetnacl-verify")


i=1

for i in ${files[*]}; do
	echo $i

	if [ ! -e bin/$i ]
		then
   		echo "File doesn't exists"
    		exit -1

	elif [ -d bin ]
		then
			date
				riscv64-unknown-elf-objdump -dC bin/$i > bin/$i.dump
			date

	else
		echo "exit 0"
	
	fi
	
done



