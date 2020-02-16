#!/bin/bash

start_time=$(date +%s)

rm -rf robotfile_path.txt
rm -rf robots.txt

echo -n "Please provide a domain: "
read domain


if [ -z $domain ];then
	echo "No domain name provided."
	exit
fi

if wget  -SO- --timeout=1 --tries=1 -q $domain/robots.txt 2>/dev/null | egrep -i "Disallow"| awk '{print $2}' >>robotfile_path.txt;then
	for i in $(cat robotfile_path.txt);do
		curl --silent --insecure --write-out "%{http_code} %{url_effective}\n" --connect-timeout 4 --max-time 4     $domain$i https://$domain$i --output /dev/null
	done
else
	echo "Robots.txt file doesn't exist"
fi

end_time=$(date +%s)
time_diff=$(( $end_time - $start_time ))
echo "Total time taken by script $time_diff seconds"
