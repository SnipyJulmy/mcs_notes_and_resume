package xi.examples

import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}


object Ex3 {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf()
      .setAppName("Ex3")

    val sc = new SparkContext(conf)

    val tweetsPath = args(0)
    val outputDataset = args(1)

    val tweetsRaw: RDD[String] = sc.textFile(tweetsPath)
    val wordCounts = tweetsRaw.
      map(line => line.split("\\s+")).
      filter(x => (x.matches("^#.*"))).
      map(word => (word, 1)).
      reduceByKey(_ + _)


    wordCounts.saveAsTextFile(outputDataset)


  } //main
}
