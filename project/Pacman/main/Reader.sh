care="public"
for i in *.pde
do
    echo ""
    echo $i
    echo ""
	 IFS=''
	 while read line
	 do
	     #for word in $line;
			 #do
			     #echo $word
			 #done
	     #echo $line
	     currentN="$line"
	     firstpart=$(echo $currentN | awk '{print $1}')
	     if [ "$care" == "$firstpart" ]
	     then echo "${currentN#* }"
	     fi
	 done < $i
done

for i in *.java
do
    echo ""
    echo $i
    echo ""
	 IFS=''
	 while read line
	 do
	     #for word in $line;
			 #do
			     #echo $word
			 #done
	     #echo $line
	     currentN="$line"
	     firstpart=$(echo $currentN | awk '{print $1}')
	     if [ "$care" == "$firstpart" ]
	     then echo "${currentN#* }"
	     fi
	 done < $i
done
