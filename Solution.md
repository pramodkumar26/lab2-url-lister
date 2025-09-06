# Lab Assignment 2 - URLCOUNT

In this lab assignment 2, I modified the Hadoop Wordcount program to URLCount program which will extract all the URL links from 2 Wikipedia articles and we have to count the occurences of it and list the count which is greater than 5. Here I did it in python using the Hadoop Streaming API, Map reduce approach.

First, I implemented this program locally in coding.csel environment. After running it locally, I tested this program by creating a dataproc cluster on the google cloud console.

I used E2 Standard Machine for running this.

I tested with two configurations:
 *1 master + 2 workers* and  *1 master + 4 workers*. 

Input has two Wikipedia files Apache_Hadoop and the MapReduce are downloaded via curl and had stored in HDFS Hadoop Distributed File System.

## Software Requirements
Coding CSEL
Google Cloud Platform (Dataproc)
Python 3
Git
Hadoop (using hadoop streaming API)
Resources used:
Map streaming API: https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/
Check for URL in string: https://www.geeksforgeeks.org/python/python-check-url-string/
Dataproc Qwiklabs: https://www.cloudskillsboost.google/focuses/586?parent=catalog



## Output 

#	20
/wiki/Doi_(identifier)	18
/wiki/Google_File_System	6
/wiki/ISBN_(identifier)	18
/wiki/MapReduce	7
/wiki/S2CID_(identifier)	14
mw-data:TemplateStyles:r1129693374	7
mw-data:TemplateStyles:r1238218222	121
mw-data:TemplateStyles:r1295599781	33
mw-data:TemplateStyles:r886049734	12




## Execution Time 
The execution is measured using: cat stream.time

- 1 Master Node & 2 Worker

real 61.2755s
user 13.69s
sys 0.841s



- 1 Master Node & 4 Workers

real 6.860s
user 10.467s
sys 0.755s



## Comparison
The 4-worker run finished in 6.86s, while the 2-worker run took 61.28s. So the 4-worker setup was about 89% faster in real time.
The "user" and "sys" times stayed around 10-13s and 1s, since they measure the master's own work. 
With such a small dataset, the 2-worker setup seemed to struggle with CPU or memory limits rather than just having normal overhead. The 4-worker configuration likely hit the sweet spot where everything could actually run efficiently.
Small clusters can sometimes create these kinds of performance penalties. Results like this show how cluster sizing really matters, even for relatively simple jobs.




Resources used: Hadoop documentation, Google Cloud Platform, QWIK Labs Dataproc, coding.csel and Wikipedia articles.


