
import sys

from pyspark import SparkContext, SparkConf

def readCSV(path):
  # default is parquet
  reader = sqlContext.read.format('csv')
  reader.option("header", "true")
  reader.option("inferSchema", "true")
  return reader.load(path)



if __name__ == "__main__":
  
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Spark Count")
  sc = SparkContext(conf=conf)

  log4jLogger = sc._jvm.org.apache.log4j 
  log = log4jLogger.LogManager.getLogger(__name__) 

  df = readCSV("/data/WorldCups.csv")

  df.printSchema()
  df.show()

  winnersDf = df.groupBy(df['Winner']).count().orderBy('count', ascending = False)
  winnersDf.show()

  winnerName = winnersDf.head().Winner
  log.info("winner is")
  log.info(winnerName)