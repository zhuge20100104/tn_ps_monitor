#! /bin/bash
#  Below are the two demo processes /sbin/init and gnome-shell
# ps_arr=("/sbin/init" "gnome-shell")
ps_arr=("usdm" "euim" "vehicle_control" "strategy" "stitching" "perception" "lam" "planning" "diagnostic" )
sleep_secs=5
res_file="out"
res_dir="./result"

help() {
	echo "********************************Top ps monitor******************************************"
	echo "Usage:  ./top_ps.sh  {sleep_secs} {res_file_prefix} "
	echo "Or use default param: ./top_ps.sh"
	echo "For default, sleep seconds is 5 seconds, res_file_prefix is out"
	echo "Example:  ./top_ps.sh  5 out"
	echo "********************************Top ps monitor help end*********************************"
}

mk_result_dir() {
	if [  -d  $res_dir ];  then
		echo "${res_dir} exists, rm and make new dir"
		rm -fr ${res_dir}
		mkdir -p ${res_dir}
	else 
		echo "result dir  does not  exists, mk new dir"
		mkdir -p ${res_dir}
	fi  
}
read_params() {
	help
	mk_result_dir
	if [ $# -eq 2 ]; then
		sleep_secs=$1 
		res_file=$2
		echo "Use custom param seconds: ${sleep_secs}, res_file_prefix: ${res_file} "
	else 
		echo "Use default param" 
	fi 
}

run_top() {
	while true
	do 
		for ps_ele in ${ps_arr[@]}
		do	
			time=`date +"%Y%m%d %H:%M:%S"`
			cpu=`ps aux | grep "${ps_ele}" | grep -v "grep" | head -n 1 | awk '{print $3}'`
			mem=`ps aux | grep "${ps_ele}" | grep -v "grep" | head -n 1 | awk '{print $6}'`
			ps_ele_arr=(`echo "${ps_ele}" | tr "/" " "`)
			echo "${time},${ps_ele},${cpu},${mem}" >> "./${res_dir}/${ps_ele_arr[${ps_ele_arr#}]}_${res_file}.csv"	 
		done 
		sleep ${sleep_secs} 
	done
}

main() {
	read_params $@
	run_top
}

main $@

