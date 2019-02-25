import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

object HashTagCounter {

  def main(args: Array[String]): Unit = {
    val conf = new SparkConf()
      .setAppName("HashTag Counter")

    val sc = new SparkContext(conf)

    val tweetsPath = args(0)
    val outputDataset = args(1)

    val tweetsRaw: RDD[String] = sc.textFile(tweetsPath)
    val wordCounts = tweetsRaw
      .flatMap(line => line.split("\\s+"))
      .filter(x => x.matches("^#.*"))
      .map(word => (word, 1))
      .reduceByKey(_ + _)

    wordCounts.saveAsTextFile(outputDataset)
  }
}
