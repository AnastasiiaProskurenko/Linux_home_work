#!/bin/bash

touch counter_wrong_ping.txt

while true; do

        Value_ping=$(ping 8.8.8.8 | awk 'NR==3 {print $5}' | cut -d'=' -f2 |  sed 's/ms$//' )


        if [ -z "$Value_ping" ]; then
        
	        echo "Wrong" >> counter_wrong_ping.txt
        
	elif [ "$Value_ping" -ge 100 ]; then
        
	        > counter_wrong_ping.txt
		echo "Ping is more than 100ms"
        
	elif [ "$Value_ping" -lt 100 ]; then
        	> counter_wrong_ping.txt
                continue
        
	fi
        
	count=$(cat counter_wrong_ping.txt | wc -l)
        
	if [ "$count" -ge 3 ]; then
        
	        echo "Attention! Three failed ping attempts!"
                break
        
	fi
sleep 1
done
