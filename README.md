# check-net
=========

Bash script that checks internet connection

## how to use?

if you have any device in office/home, run `nohup bash check_net.sh &`.  nohub will store the output of the script in `~/nohup.txt` and the script will make output in `~/status.txt`

## useful crontabs

you can write local crons that will check every hour if script is running and weekly cron to delete old nohub text (if you have)

```
10 10 * * 7 echo '' > /home/<HOMEDIR>/nohup.out

1 * * * * if [ $(ps -C bash u | grep -c 'bash check_net.sh') -eq 0 ]; then $(nohup bash check_net.sh > /home/<HOMEDIR>/nohup.out &) ; fi
```
