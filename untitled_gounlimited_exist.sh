#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s
input="./gg"
while IFS= read -r line
do
   echo $line
   c="$(wget -qO-  $line | grep -e 'gounlimited.to' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
   echo c is  ${c}
   if  [ -z "$c" ]; then
      echo $line >> no_gounlimited.txt
      continue
   fi
   echo $line >> have_gounlimited.txt

done < "$input"
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
