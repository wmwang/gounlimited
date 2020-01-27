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

   gounlimited_url="www.tubeoffline.com/downloadFrom.php?host=GoUnlimited&video=""$(wget -qO-  $line | grep -e 'gounlimited.to' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
   echo gounlimited_url is $gounlimited_url
   if  [ -z "$gounlimited_url" ]; then
      echo without URL
      continue
   fi

   if [ -f ./`echo ${gounlimited_url} |sed 's/.*\///g'` ]; then
      echo file is exist
      continue
   fi

   emb_url="$(curl -X HEAD -I $gounlimited_url | grep -e 'Location' | sed "s/Location: //g"| sed "s/html.*/html/g")"
   echo emb_url is $emb_url
   if  [ -z "$gounlimited_url" ]; then
      echo without URL
      continue
   fi
   curl $emb_url |grep -e "fs" |sed "s/.*http/http/g" |sed "s/\" rel.*//g" >> ture_url
   echo ${gounlimited_url} |sed 's/.*\// out=/g' >>ture_url
   echo ture_url is `echo $ture_url`

   if [ -f ./`echo ${gounlimited_url} |sed 's/.*\///g'` ]; then
      echo file is exist
      continue
   fi
   
#merge to complete URL
   url="https://gounlimited.to/dl?op=download_orig&id="${b}"&mode=n&hash="${c}""
   data="op=download_orig&id="${b}"&mode=n&hash="${c}"" 
#show URL

# require the realy video file URL
      telegram -t 1012817406:AAFOwSdJhx-Cu9GUJ0fGslqjRNTIlEOZTwg  -c @isosoman "add download"_`echo $gounlimited_url`
 

   if [ `cat ture_url |wc -l` -eq 10 ]
   then
      #telegram -t 1012817406:AAFOwSdJhx-Cu9GUJ0fGslqjRNTIlEOZTwg  -c @isosoman `cat gounlimited_betch.txt `
      aria2c -c -i ture_url  -j 5 -x 3 -s 3 --file-allocation=none
      telegram -t 1012817406:AAFOwSdJhx-Cu9GUJ0fGslqjRNTIlEOZTwg  -c @isosoman "finish_section_download"
      rm ture_url
   fi

done < "$input"
telegram -t 1012817406:AAFOwSdJhx-Cu9GUJ0fGslqjRNTIlEOZTwg  -c @isosoman "all_finish"
#aria2c -c -i gounlimited_betch.txt  -j 3 -x 3 -s 3
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
