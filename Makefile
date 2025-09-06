USER=$(shell whoami)
##
## Configure the Hadoop classpath for the GCP dataproc environment
##
HADOOP_CLASSPATH=$(shell hadoop classpath)

WordCount1.jar: WordCount1.java
	javac -classpath $(HADOOP_CLASSPATH) -d ./ WordCount1.java
	jar cf WordCount1.jar WordCount1*.class	
	-rm -f WordCount1*.class

filesystem:
	-hdfs dfs -mkdir /user
	-hdfs dfs -mkdir /user/$(USER)

prepare: filesystem
	-hdfs dfs -rm -r input
	-hdfs dfs -mkdir input
	curl https://en.wikipedia.org/wiki/Apache_Hadoop > /tmp/input.txt
	hdfs dfs -put /tmp/input.txt input/file01
	curl https://en.wikipedia.org/wiki/MapReduce > /tmp/input.txt
	hdfs dfs -put /tmp/input.txt input/file02
	-rm -f /tmp/input.txt

run: WordCount1.jar
	-hdfs dfs -rm -r output
	hadoop jar WordCount1.jar WordCount1 input output

##
## Hadoop streaming setup for Dataproc
## Dataproc typically uses Hadoop 3.3.x
##
HADOOP_V=$(shell hadoop version | head -1 | cut -d' ' -f2)
STREAM_JAR = $(shell find /usr/lib/hadoop -name "hadoop-streaming*.jar" | head -1)

stream:
	-hdfs dfs -rm -r stream-output
	hadoop jar $(STREAM_JAR) \
	-mapper url_mapper.py \
	-reducer url_reducer.py \
	-file url_mapper.py -file url_reducer.py \
	-input input \
	-output stream-output

# Add target to view streaming results
viewresults:
	hdfs dfs -cat stream-output/part-00000

# Clean up all outputs
clean:
	-hdfs dfs -rm -r output
	-hdfs dfs -rm -r stream-output
	-hdfs dfs -rm -r input
