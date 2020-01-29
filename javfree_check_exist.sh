#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s
input="./gg"
while IFS= read -r line
do
   echo $line
   line=${line%$'\r'}

   echo line is $line


   if [ -f ./`echo ${line} |sed 's/.*\///g'|sed 's/.html//g'` ]; then
      
      continue
   fi  
   echo $line
done < "$input"
#aria2c -c -i gounlimited_betch.txt  -j 3 -x 3 -s 3
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
