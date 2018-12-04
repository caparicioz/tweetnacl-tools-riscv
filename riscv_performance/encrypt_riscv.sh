#!/bin/bash
if [ ! -e ../riscv/tweetnacl-encrypt_LordOfTheRings.out ]
then
    echo "Encryption with no enhancement should be run first"
    exit -1
fi
[[ -d sandbox ]] || mkdir sandbox
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
    exit -1
fi
echo
cycles_original=`head -n 3 ../riscv/tweetnacl-encrypt_LordOfTheRings.out | tail -n 1 | awk '{print $6}'`
cycles=`head -n 3 tweetnacl-encrypt_LordOfTheRings.out | tail -n 1 | awk '{print $6}'`
cycles_less=`expr $cycles_original - $cycles`
performance_cycles=$(echo "scale = 3; ($cycles_original - $cycles) * 100 / $cycles_original" | bc)
echo "$cycles_less less cycles executed for a performance enhancement of $performance_cycles %" 
time_original=`head -n 4 ../riscv/tweetnacl-encrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
time_=`head -n 4 tweetnacl-encrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
time_less=`expr $time_original - $time_`
performance_time=$(echo "scale = 3; ($time_original - $time_) * 100 / $time_original" | bc)
echo "Encryption took $time_less less time units for a performance enhancement of $performance_time %" 
instr_original=`head -n 5 ../riscv/tweetnacl-encrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
instr=`head -n 5 tweetnacl-encrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
performance_instr=$(echo "scale = 3; ($instr_original - $instr) * 100 / $instr_original" | bc)
instr_less=`expr $instr_original - $instr`
echo "$instr_less less instructions retired for a performance enhancement of $performance_instr %"
echo
./finding_encrypt.sh
