#!/bin/bash
fileName1='dump/tweetnacl-sigpair.dump'

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


count1=0
count2=0
count3=0
count4=0
count5=0
count6=0
count7=0
count8=0
count9=0
count10=0
count11=0
count12=0
count13=0
count14=0
count15=0
count16=0
count17=0
count18=0

        while read line
        do
                if echo $line| grep $stringFunc1; then
                        count1=`expr $count1 + 1`
                fi

                if echo $line| grep $stringFunc2; then
                        count2=`expr $count2 + 1`
                fi

                if echo $line| grep $stringFunc3; then
                        count3=`expr $count3 + 1`
                fi

                if echo $line| grep $stringFunc4; then
                        count4=`expr $count4 + 1`
                fi

                if echo $line| grep $stringFunc5; then
                        count5=`expr $count5 + 1`
                fi

                if echo $line| grep $stringFunc6; then
                        count6=`expr $count6 + 1`
                fi

                if echo $line| grep $stringFunc7; then
                        count7=`expr $count7 + 1`
                fi

                if echo $line| grep $stringFunc8; then
                        count8=`expr $count8 + 1`
                fi

                if echo $line| grep $stringFunc9; then
                        count9=`expr $count9 + 1`
                fi

                if echo $line| grep $stringFunc10; then
                        count10=`expr $count10 + 1`
                fi

                if echo $line| grep $stringFunc11; then
                        count11=`expr $count11 + 1`
                fi

                if echo $line| grep $stringFunc12; then
                        count12=`expr $count12 + 1`
                fi

                if echo $line| grep $stringFunc13; then
                        count13=`expr $count13 + 1`
                fi

                if echo $line| grep $stringFunc14; then
                        count14=`expr $count14 + 1`
                fi

                if echo $line| grep $stringFunc15; then
                        count15=`expr $count15 + 1`

		 fi

                if echo $line| grep $stringFunc16; then
                        count16=`expr $count16 + 1`

		 fi

                if echo $line| grep $stringFunc17; then
                        count17=`expr $count17 + 1`


                fi

                if echo $line| grep $stringFunc18; then
                        count18=`expr $count18 + 1`
                fi
        done < "$fileName1"
 
echo -e "The function '$stringFunc1' occurs $count1 
         \nThe function '$stringFunc2' occurs $count2
         \nThe function '$stringFunc3' occurs $count3
         \nThe function '$stringFunc4' occurs $count4
         \nThe function '$stringFunc5' occurs $count5
         \nThe function '$stringFunc6' occurs $count6
         \nThe function '$stringFunc7' occurs $count7
         \nThe function '$stringFunc8' occurs $count8
         \nThe function '$stringFunc9' occurs $count9 
         \nThe function '$stringFunc10' occurs $count10
         \nThe function '$stringFunc11' occurs $count11
         \nThe function '$stringFunc12' occurs $count12
         \nThe function '$stringFunc13' occurs $count13
         \nThe function '$stringFunc14' occurs $count14
         \nThe function '$stringFunc15' occurs $count15
	 \nThe function '$stringFunc16' occurs $count16
         \nThe function '$stringFunc17' occurs $count17
         \nThe function '$stringFunc18' occurs $count18" > dump/Inst_in_sigpair.txt


