#/usr/bin/env bash
#
# check internet connectivity

# globals
readonly ip_addresses=("8.8.8.8" "8.8.4.4" "4.2.2.2")
readonly dns_addresses=("google.com" "facebook.com") # can add a check dig +short fqdn
readonly sleep_cycle=5 # sleep cycle in seconds
internet_is_down='false'

# functions
timestamp() {
	date +"%s"
}
echodate() {
	echo -n "[$(date +'%b %d, %r')]";
}
# funtime
while true;
do
	#date="[$(date +'%b %d, %r')] ";
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
			total_down=$(timestamp)
			internet_is_down='true'
			echo "$(echodate) INTERNET_DOWN" >> ~/status.txt;
		#else
			#we do nothing cause we are down...
		fi
		echo -n "X";
	else
		if [ $internet_is_down = 'true' ]
		then
			total_down_before_calc=$total_down
			timestamp=$(timestamp)
			total_down=$(expr $(timestamp) - $total_down)
			echo -n $total_down
			nice_total_down=$(date +%T -d "1/1 + $total_down sec")
			echo "$(echodate) INTERNET_UP $nice_total_down ($total_down)" >> ~/status.txt
			internet_is_down='false'
			total_down=0
		fi
		echo -n "."
	fi
	sleep $sleep_cycle;
done
