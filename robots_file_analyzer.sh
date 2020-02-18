#!/bin/bash

rm -rf robotfile_path.txt

echo -n "Please provide a domain: "
read domain


if [ -z $domain ];then
	echo "No domain name provided."
	exit
fi

echo -n "Please provide timeout[2]: "
read wgettimeout

echo -n "Please provide tries[2]: "
read maxretries

echo -n "Please provide connect-timeout[2]: "
read connecttimeout

echo -n "Please provide max-time[2]: "
read maxtime

start_time=$(date +%s)

if wget  -SO- --timeout=${wgettimeout:-2} --tries=${maxretries:-2} -q $domain/robots.txt 2>/dev/null | egrep -i "Disallow"| awk '{print $2}' >>robotfile_path.txt;then
	for i in $(cat robotfile_path.txt);do
		curl --silent --insecure --write-out "%{http_code} %{url_effective}\n" --connect-timeout ${connecttimeout:-2} --max-time ${maxtime:-2} $domain$i https://$domain$i --output /dev/null
	done
else
	echo "Robots.txt file doesn't exist"
fi

end_time=$(date +%s)
time_diff=$(( $end_time - $start_time ))
echo "Total time taken by script $time_diff seconds"
