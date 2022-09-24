#! /bin/bash

ps_arr=("/sbin/init" "gnome-shell")
sleep_secs=5
res_file="out"
while true
do 
	for ps_ele in ${ps_arr[@]}
	do	
		time=`date +"%Y%m%d %H:%M:%S"`
		cpu=`ps aux | grep "${ps_ele}" | grep -v "grep" | head -n 1 | awk '{print $3}'`
		mem=`ps aux | grep "${ps_ele}" | grep -v "grep" | head -n 1 | awk '{print $6}'`
		ps_ele_arr=(`echo "${ps_ele}" | tr "/" " "`)
		echo "${time}|${ps_ele}|${cpu}|${mem}" >> "./${ps_ele_arr[${ps_ele_arr#}]}_${res_file}.txt"	 
	done 
	sleep ${sleep_secs} 
done
