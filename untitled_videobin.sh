#!/bin/bash
# Get HTML of page from user's input, get all of the image links, and make sure URLs have HTTPs
#curl $1 | grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif)" -o | sed "s/^(https?)?\/\//https\:\/\//g" -r > urls.txt
#get the line contain parameter about hash and ID info
#sleep $[ ( $RANDOM % 10 )  ]s
#!/bin/bash
input="./gg"
while IFS= read -r line
do
  	echo $line

	c="$(curl $line | grep -e 'videobin.co' | sed "s/.*http/http/g"|sed "s/\" rel.*//g")"
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
	curl ${c} | grep -e 'm3u8'| sed "s/http/\nhttp/g"| grep -e 'mp4' | sed "s/mp4.*/mp4/g"   > ${d}
    
	n=0
	a=./urls.txt
	b=0
	echo url_for_download is `cat ${d}`
	e=0


	if ! [ -f ./`echo ${c} |sed 's/.*\///g'` ]; then
        touch `echo ${c} |sed 's/.*\///g'`
		wget -i ${d} -c -O `echo ${c} |sed 's/.*\///g'`
	fi
	rm ${d}

done < "$input"
# Get full-res URLs instead of thumbnails and re-saving urls.txt

#sed -Ei "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt

# Downloading Images
#wget -i urls.txt -P downloads/
