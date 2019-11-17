#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s


echo $1
c="$(curl $1 | grep -e 'videobin.co' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
echo c is  ${c}
if  [ -z "$c" ]; then
   echo without URL
   echo "==" >> temp
   exit 1
fi

echo ${c}  >> temp