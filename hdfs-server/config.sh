


mkdir input cp etc/hadoop/*.xml input bin/hadoop jar

share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.0.jar grep input output 'dfs[a-z.]+' 
cat output/*

