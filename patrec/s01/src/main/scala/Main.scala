package s01

object Main extends App {
  val k: Int = 1

  val trainFile: String = "train.csv"
  val testFile: String = "test.csv"

  val trainText = scala.io.Source.fromFile(trainFile).mkString
  val trainSet = trainText.split("\n").map { line =>
    val l = line.split(",")
    LabeledPixel(l.head.toInt, l.tail.map(_.toInt))
  }
  trainSet.foreach(println)
}

case class LabeledPixel(label: Int, data: Array[Int])
