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
  
#get the video file
   if ! [ -f ./`cat ${d}|sed 's/.*\///g'` ]; then
      touch `cat ${d}|sed 's/.*\///g'`
      curl --cookie cookies_ubiq.txt  -J -L ${c} -C - --output ${d} 
   fi
   rm ${d}

done < "$input"
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
