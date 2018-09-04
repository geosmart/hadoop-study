
rdd = sc.textFile("/data/WorldCups.csv")

lines_len = rdd.map(lambda line: len(line))
total_len = lines_len.reduce(lambda a, b: a + b)
