#!/bin/bash
if [ ! -e ../riscv/tweetnacl-decrypt_LordOfTheRings.out ]
then
    echo "Decryption with no enhancement should be run first"
    exit -1
fi
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
echo
cycles_original=`head -n 3 ../riscv/tweetnacl-decrypt_LordOfTheRings.out | tail -n 1 | awk '{print $6}'`
cycles=`head -n 3 tweetnacl-decrypt_LordOfTheRings.out | tail -n 1 | awk '{print $6}'`
cycles_less=`expr $cycles_original - $cycles`
performance_cycles=$(echo "scale = 3; ($cycles_original - $cycles) * 100 / $cycles_original" | bc)
echo "$cycles_less less cycles executed for a performance enhancement of $performance_cycles %" 
time_original=`head -n 4 ../riscv/tweetnacl-decrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
time_=`head -n 4 tweetnacl-decrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
time_less=`expr $time_original - $time_`
performance_time=$(echo "scale = 3; ($time_original - $time_) * 100 / $time_original" | bc)
echo "Decryption took $time_less less time units for a performance enhancement of $performance_time %" 
instr_original=`head -n 5 ../riscv/tweetnacl-decrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
instr=`head -n 5 tweetnacl-decrypt_LordOfTheRings.out | tail -n 1 | awk '{print $7}'`
performance_instr=$(echo "scale = 3; ($instr_original - $instr) * 100 / $instr_original" | bc)
instr_less=`expr $instr_original - $instr`
echo "$instr_less less instructions retired for a performance enhancement of $performance_instr %" 
