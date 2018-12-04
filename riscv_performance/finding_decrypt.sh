#!/bin/bash
fileName1='dump/tweetnacl-decrypt.dump'

stringFunc1='slil8or'
stringFunc2='slil8and'
stringFunc3='idxc4'
stringFunc4='idxc16'
stringFunc5='arg4'
stringFunc6='arg16'
stringFunc7='addsub17'
stringFunc8='packf'
stringFunc9='sub64'
stringFunc10='modcarry'
stringFunc11='scalu8'
stringFunc12='packb'
stringFunc13='packc'
stringFunc14='mfa'
stringFunc15='modcarrya'
stringFunc16='modcarryb'
stringFunc17='ori64'
stringFunc18='ld32in'


count1=`grep $stringFunc1 $fileName1 | wc -l`
count2=`grep $stringFunc2 $fileName1 | wc -l`
count3=`grep $stringFunc3 $fileName1 | wc -l`
count4=`grep $stringFunc4 $fileName1 | wc -l`
count5=`grep $stringFunc5 $fileName1 | wc -l`
count6=`grep $stringFunc6 $fileName1 | wc -l`
count7=`grep $stringFunc7 $fileName1 | wc -l`
count8=`grep $stringFunc8 $fileName1 | wc -l`
count9=`grep $stringFunc9 $fileName1 | wc -l`
count10=`grep $stringFunc10 $fileName1 | wc -l`
count11=`grep $stringFunc11 $fileName1 | wc -l`
count12=`grep $stringFunc12 $fileName1 | wc -l`
count13=`grep $stringFunc13 $fileName1 | wc -l`
count14=`grep $stringFunc14 $fileName1 | wc -l`
count15=`grep $stringFunc15 $fileName1 | wc -l`
count16=`grep $stringFunc16 $fileName1 | wc -l`
count17=`grep $stringFunc17 $fileName1 | wc -l`
count18=`grep $stringFunc18 $fileName1 | wc -l`
 
  echo -e "The function '$stringFunc1' occurs $count1 times\nThe function '$stringFunc2' occurs $count2 times\nThe function '$stringFunc3' occurs $count3 times\nThe function '$stringFunc4' occurs $count4 times\nThe function '$stringFunc5' occurs $count5 times\nThe function '$stringFunc6' occurs $count6 times\nThe function '$stringFunc7' occurs $count7 times\nThe function '$stringFunc8' occurs $count8 times\nThe function '$stringFunc9' occurs $count9 times\nThe function '$stringFunc10' occurs $count10 times\nThe function '$stringFunc11' occurs $count11 times\nThe function '$stringFunc12' occurs $count12 times\nThe function '$stringFunc13' occurs $count13 times\nThe function '$stringFunc14' occurs $count14 times\nThe function '$stringFunc15' occurs $count15 times\nThe function '$stringFunc16' occurs $count16 times\nThe function '$stringFunc17' occurs $count17 times\nThe function '$stringFunc18' occurs $count18" times | tee dump/Inst_in_decrypt.txt


