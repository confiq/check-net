#/usr/bin/env bash
#
# check internet connectivity

# globals
readonly ip_addresses=("8.8.8.8" "8.8.4.4" "4.2.2.2")
readonly dns_addresses=("google.com" "facebook.com") # can add a check dig +short fqdn
readonly sleep_cycle=5 # sleep cycle in seconds

while true;
do
	date="[$(date +'%b %d, %r')] ";
	works='true';
	for check_address in ${ip_addresses[@]}
	do
		if ping -W 5 -c 1 $check_address > /dev/null;
		then
			works='true';
			continue;
		else
			echo $check_address does not work
			works='false';
		fi
	done
	if [ $works = 'false' ]
	then
		echo "error"
		echo "$date Internet is down!" >> ~/status.txt;
	else
		sleep $sleep_cycle;
	fi
done
