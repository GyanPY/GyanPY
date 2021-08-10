#! /bin/bash
# This file is to whitelist the file and get the count of the number of metrics

#read the file
#get the metrics appId in an array
#create a counter to increase the no of metrics json
#(AC) if whitelisted==false then skip

filename=("$@")
trap "echo Running Script Cancelled; exit" 2 3 15

if [ $# -gt 1 ] 
then
	#statements
	echo "The script accept only one argument. Current Argument count $#"
	exit 1
elif ! [ -r ${filename[0]} ]
then
	echo "File read permission is not given. Kindly Check the Permission"
else
	echo "Parsing the file: ${filename[0]}"
	echo "This might take a while to run, if the file size is >100 MB."
	Whitelisting() {
          
          tempfile=${filename[0]}
          whitelistfile=$tempfile-newline
          sed 's/}]/\
          /g' $tempfile > $whitelistfile

          count=0
          while IFS= read -r line
          do
          	appId[$count]=$( echo $line | awk -F ":" '{print $1}' )
          	metrics[$count]=$line
          	(( count++ ))
          done < $whitelistfile
          


          lineindex=0

          for i in ${appId[*]}
          do
          	if [[ $i != '}' ]]
            then
            	metrics_count=$(echo ${metrics[$lineindex]} | grep -o metricname | wc -l )
                i=$( echo $i | awk -F "\"" '{print $(NF-1)}'  )
                result="$result `echo \"$i : $metrics_count ?\"`"
                (( lineindex++ ))
          		#statements
          	fi
          done

          echo "$result" | tr "?" "\n" |  sort -k 3 -n -r
          rm $whitelistfile
          
    }
fi

showLoading() {
  mypid=$!
  loadingText=$1

  echo -ne "$loadingText\r"

  while kill -0 $mypid 2>/dev/null; do
    echo -ne "$loadingText.\r"
    sleep 0.5
    echo -ne "$loadingText..\r"
    sleep 0.5
    echo -ne "$loadingText...\r"
    sleep 0.5
    echo -ne "\r\033[K"
    echo -ne "$loadingText\r"
    sleep 0.5
  done

  echo "Finished Running of Script"
}

Whitelisting & showLoading "Please Wait"