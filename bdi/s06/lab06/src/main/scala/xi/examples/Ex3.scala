package xi.examples

import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

object Ex3 {
  def main(args: Array[String]): Unit = {

    val conf = new SparkConf()
      .setAppName("Task 3")
      .setMaster("local")
    val sc = new SparkContext(conf)

    val tweetsPath = args(0)
    val stopWordsPath = args(1)
    val outputDataset = args(2)

    val tweetsRaw: RDD[String] = sc.textFile(tweetsPath)
    val stopWords: Array[String] = sc.textFile(stopWordsPath)
      .flatMap(_.split(","))
      .map(_.replaceAll("^\\s+", ""))
      .collect()

    // recover the city and the tweet text
    // city is always the first element
    // the text is always the penultimate element

    val tweets: RDD[(String, String)] = tweetsRaw.map { line =>
      val elt = line.split("\t")
      (elt.head, elt(elt.length - 2))
    }

    val filteredTweetsText: RDD[String] = tweets.filter { ct =>
      val city = ct._1
      (city matches "San Francisco") || (city matches "Chicago")
    }.map {
      _._2 // recover the tweet text
        .split(" ") // split the tweet into words
        .filterNot(s => stopWords.contains(s.toLowerCase.replaceAll("^\\s+", ""))) // remove stop words
        .mkString(" ")
    }

    filteredTweetsText.saveAsTextFile(outputDataset)
  }
}
