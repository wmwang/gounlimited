#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s
input="./gg"
rm gounlimited_betch.cmd
while IFS= read -r line
do
   echo $line
   line=${line%$'\r'}
   c="$(wget -qO-  $line | grep -e 'gounlimited.to' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
   echo c is $c
   if  [ -z "$c" ]; then
      echo without URL
      continue
   fi

   echo ${c} |sed 's/.*\///g'
   if [ -f ./`echo ${c} |sed 's/.*\///g'` ]; then
      echo file is exist
      continue
   fi
   d=temp
   echo d is ${d}
   curl ${c} | grep -e 'download_video' | sed "s/.*download_video(//g" | sed "s/)\">.*//g" | sed "s/'//g"   > ${d} 
    
   n=0
   a=./urls.txt
   b=0
   echo url_include_hash is `cat ${d}`
   e=0
   #get the ID info to $b and get the hash to $c
   for i in `cat ${d} | tr ',' '\n'` ; do
      let n=$n+1
      var=`echo "var${n}"`
      echo $var is ... ${i}
      if [ $n -eq 1 ]
      then
         #statementsb
         b=${i}
         #echo b is ...${b}
      elif [ $n -eq 3 ]; then
         c=${i}
      fi
   done
#merge to complete URL
   url="start firefox \"https://gounlimited.to/dl?op=download_orig&id="${b}"&mode=n&hash="${c}"\""
#show URL
   echo ${url} >> gounlimited_betch.cmd
   
# require the realy video file URL
   #wget -qO-  ${url}  --load-cookies cookies$(($RANDOM%10)).txt | grep -e 'Direct Download Link' | sed "s/.*href=\"//g" |  sed "s/\">D.*//g"  >> gounlimited_betch.txt 
   #cat  gounlimited_betch.txt | sed 's/.*\///g'


done < "$input"

#aria2c -c -i gounlimited_betch.txt  -j 3 -x 3 -s 3
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
