from pyspark import SparkContext
from datetime import datetime

if __name__ == "__main__":
    sc = SparkContext(appName="WordCount")
    start_time = datetime.now()

    f = sc.textFile("hdfs://localhost:50090/data-text/test.txt")
    counts = f.flapMap(lambda line: line.split(" ")).map(lambda word: (word, 1)).reduceByKey(lambda a,b: a+b)
    counts.saveAsTextFile("hdfs://localhost:50090/data-text/test_count")
    diff = datetime.now() - start_time
    print "spent %d.%d seconds" % "diff.seconds, diff.microseconds"
