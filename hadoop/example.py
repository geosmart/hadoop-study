from pyspark.sql import SparkSession



data = [
  ('First', 1),
  ('Second', 2),
  ('Third', 3),
  ('Fourth', 4),
  ('Fifth', 5)
]

df = sparkSession.createDataFrame(data)

df.write.csv("hdfs://namenode:8020/user/hdfs/test/example.csv")

exit()