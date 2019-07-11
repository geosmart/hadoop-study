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

  cupDf = readCSV('/data/WorldCups.csv')

  matchesDf = readCSV('/data/WorldCupMatches.csv')
  matchesInCupsDf = matchesDf.join(cupDf, matchesDf.Year == cupDf.Year, how='left')
  matchesInCupsDf.printSchema()

