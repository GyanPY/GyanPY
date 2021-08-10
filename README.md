To use the count script Follow the below steps
1- Download the meta file to the local machine
2- Run the above script by passing the filename or full path
	
	Example->
	./ams-metrics-whitelist.sh /Users/xxx/Documents/xxxxx/meta-out1.json 

	The output will be like below.
	+++++++++++++++++++
	Parsing the file: meta-out1.json
	This might take a while to run, if the file size is >100 MB.
 	kafka_broker :   106083 
 	ams-hbase :     3926 
 	ambari-infra-solr :       95 
 	ambari_server :       79 
 	HOST :       58 
 	timeline_metric_store_watcher :        2 
 	amssmoketestfake :        2 

	Finished Running of Script
	+++++++++++++++++++
