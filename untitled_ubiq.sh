#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s
input="./gg"
while IFS= read -r line
do
   #!ech the line of URL from ubiq_file_com
   echo $line
   c="$(curl $line | grep -e 'ubiqfile.com' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
   d=`echo ${c}|sed 's/.*\///g'|sed 's/.html//g'`
   #! get the right URL form the web
   #!print the info about the full URL
   echo c is  ${c}
   #!print the tail of the URL
   echo d is  ${d}
   #!if the url is not correct, then print without URL, and exit the code
   if  [ -z "$c" ]; then
      echo without URL
      continue
   fi
   
   #! if file has exist(depend on the file name, then show the information about the file is exist, and leave the code
   echo ${c} |sed 's/.*\///g'
   if [ -f ./`echo ${d} ` ]; then
      echo file is exist
      continue
   fi
#get the video file
   if ! [ -f ./`echo ${d}` ]; then
      touch `echo ${c}|sed 's/.*\///g'`
      curl --cookie cookies_ubiq.txt  -J -L ${c} -C - --output ${d} 
   fi

done < "$input"
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
