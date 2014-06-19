#/bin/bash
address=("8.8.8.8" "8.8.4.4" "4.2.2.2")
#aaddress=("google.com" "www.google.com")
while true;
do
	time="[$(date +'%b %d, %r')] ";
	works='true';
	for check_address in "${address[@]}"
	do
		if ping -c 1 -W 1 $check_address > /dev/null;
		then
			works='true';
			break;
		else
			echo $check_address does not work
			works='false';
		fi
	done
	if [ $works = 'false' ]
	then
		echo "error"
		echo "$time Internet is down! $check_address" >> /home/confiq/status.txt;
	else
		sleep 3;
	fi
done
