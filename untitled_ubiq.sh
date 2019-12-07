#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s
input="./gg"
while IFS= read -r line
do
   echo $line
   c="$(curl $line | grep -e 'ubiqfile.com' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
   echo c is  ${c}
   if  [ -z "$c" ]; then
      echo without URL
      continue
   fi

   echo ${c} |sed 's/.*\///g'
   if [ -f ./`echo ${c} |sed 's/.*\///g'` ]; then
      echo file is exist
      continue
   fi
   d=`date +%s`
   echo d is ${d}
   curl ${c} | grep -e 'download_video' | sed "s/.*download_video(//g" | sed "s/)\">.*//g" | sed "s/'//g"  > ${d}
    
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
   url="https://gounlimited.to/dl?op=download_orig&id="${b}"&mode=n&hash="${c}""
#show URL
   echo url is ...${url}
# require the realy video file URL
   curl ${url}  --cookie cookies.txt | grep -e 'Direct Download Link' | sed "s/.*href=\"//g" |  sed "s/\">D.*//g" > ${d} 
   cat  ${d} | sed 's/.*\///g'
#get the video file
   if ! [ -f ./`cat ${d}|sed 's/.*\///g'` ]; then
      touch `cat ${d}|sed 's/.*\///g'`
      wget -i ${d} -c
   fi
   rm ${d}

done < "$input"
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
