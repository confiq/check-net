#/usr/bin/env bash
#
# check internet connectivity

# globals
readonly ip_addresses=("8.8.8.8" "8.8.4.4" "4.2.2.2")
readonly dns_addresses=("google.com" "facebook.com") # can add a check dig +short fqdn
readonly sleep_cycle=5 # sleep cycle in seconds
internet_is_down='false'
while true;
do
	date="[$(date +'%b %d, %r')] ";
	works='true';
	for check_address in "${ip_addresses[@]}"
	do
		if ping -W 5 -c 1 $check_address > /dev/null;
		then
			works='true';
			break;
		else
			echo -n "E";
			works='false';
		fi
	done
	if [ $works = 'false' ]
	then
		if [ $internet_is_down = 'false' ]
		then 
			internet_is_down='true'
			echo "$date INTERNET_DOWN" >> ~/status.txt;
		#else
			#we do nothing cause we are down...
		fi
		echo -n "X";
	else
		if [ $internet_is_down = 'true' ]
		then
			echo "$date INTERNET_UP" >> ~/status.txt
			internet_is_down='false'
		fi
		echo -n "."
		sleep $sleep_cycle;
	fi
done
