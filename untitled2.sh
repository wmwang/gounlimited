#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
d=`date +%s`
echo d is ${d}
curl $1 | grep -e 'download_video' | sed "s/.*download_video(//g" | sed "s/)\">.*//g" | sed "s/'//g"  > ${d}

n=0
a=./urls.txt
b=0
c=0


#get t:qhe ID info to $b and get the hash to $c
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
#get the video file
wget -i ${d} -c
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txti

# Downloading Images
#wget -i urls.txt -P downloads/
rclone move `cat ${d} | sed "s/.*\///g"` mm:av/xxx_anal_09 -P
rm ${d}
