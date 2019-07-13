import sys

from pyspark import SparkContext, SparkConf

if __name__ == "__main__":

  destinFile = sys.argv[1] or "/data/report3.txt"

  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Spark Count")
  sc = SparkContext(conf=conf)

  log4jLogger = sc._jvm.org.apache.log4j 
  log = log4jLogger.LogManager.getLogger(__name__) 

  rdd = sc.textFile("/data/WorldCups.csv")

  lines_len = rdd.map(lambda line: len(line))
  total_len = lines_len.reduce(lambda a, b: a + b)

  log.info("total")

  log.info(total_len)

  rdd = sc.parallelize([str(total_len)])

  rdd.saveAsTextFile(destinFile)

  print total_len
