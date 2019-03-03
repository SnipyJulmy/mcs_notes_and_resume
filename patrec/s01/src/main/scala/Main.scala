import java.io._

import scala.Function._
import scala.io.Source
import scala.language.implicitConversions

object Main extends App {

  type Label = Int

  // Config
  val trainFile: String = "train.csv"
  val testFile: String = "test.csv"
  val saveDirectoryPath: String = "results"
  val distanceDirectoryPath: String = "distances"

  val doOverrideResults: Boolean = false
  val doOverrideDistances: Boolean = false

  // manage save directory
  val saveDir: File = new File(saveDirectoryPath)
  if (saveDir.exists() && doOverrideResults) saveDir.delete()
  if (!saveDir.exists())
    if (!saveDir.mkdirs()) {
      println(s"Can't create directory $saveDirectoryPath... exit")
      System.exit(0)
    }

  // manage distances directory
  val distDir: File = new File(distanceDirectoryPath)
  if (distDir.exists() && doOverrideDistances) distDir.delete()
  if (!distDir.exists())
    if (!distDir.mkdirs()) {
      println(s"Can't create directory $distanceDirectoryPath... exit")
      System.exit(0)
    }

  val kToTest = List(1, 3, 5, 10, 15)
  val nbSampleToClassify = 15001
  val distanceFunctions: List[DistanceFunction] = List(
    DistanceFunction.EuclidianDistance,
    DistanceFunction.ManhattanDistance,
    DistanceFunction.mkMinkowskiDistance(2),
    DistanceFunction.mkMinkowskiDistance(4),
    DistanceFunction.mkMinkowskiDistance(6)
  )

  println("Load train set")
  val trainSet = LabeledImage.fromCSV(trainFile)
  println("Load test set")
  val testSet = LabeledImage.fromCSV(testFile)

  val results = distanceFunctions.flatMap { f =>
    val testSamples = testSet.take(nbSampleToClassify)
    val knn = new KNN(kToTest, trainSet)
    knn.classify(testSamples, f)
  }

  println(s"Save the result to $saveDirectoryPath/")
  results.foreach(r => Result.save(mkSavePath(Result.mkName(r)), r))

  results.foreach(_.printReport())

  def mkSavePath(filename: String): String = s"$saveDirectoryPath/$filename"

  def mkDistPath(filename: String): String = s"$distanceDirectoryPath/$filename"

  class KNN(val ks: List[Int],
            val trainSet: Vector[LabeledImage]) {

    def classify(testSet: Vector[LabeledImage], distanceFunction: DistanceFunction): List[Result] = {

      val name = DistancesSave.name(testSet.length, trainSet.length, distanceFunction)
      val distances = DistancesSave.loadOrElse(mkDistPath(name), {
        println(s"compute the distances for ${testSet.length} x ${trainSet.length} with ${distanceFunction.name}")
        val res = testSet.par.map { testImage =>
          testImage.label -> trainSet.par.map { trainImage =>
            trainImage.label -> distanceFunction(testImage.data)(trainImage.data)
          }.toVector.sortBy(_._2)
        }.toVector
        print(s"save distances to $name...")
        DistancesSave.save(mkDistPath(name), res)
        println(s" ... done !")
        res
      })

      println("\n compute knn based on calculated distances")
      ks.map { k =>
        println(s"compute for k=$k")
        new Result(
          k = k,
          distanceFunction = distanceFunction.name,
          givenLabels = distances.map(d => assignLabel(k, d._2)),
          labels = distances.map(_._1)
        )
      }
    }

    // distance is a function that take two vectors and return the distance between them
    def assignLabel(k: Int, distances: Vector[(Label, Double)]): Label = {
      distances.take(k).groupBy(p => p._1).maxBy(_._2.length)._1
    }
  }

  @SerialVersionUID(100L)
  class Result(val k: Int,
               val givenLabels: Vector[Label],
               val labels: Vector[Label],
               val distanceFunction: String,
              ) extends Serializable {

    require(givenLabels.length == labels.length)

    def printReport(): Unit = println {
      s"""
         |######################################################
         | Classification report
         | \t sample size : ${labels.length}
         | \t k           : $k
         | \t distance    : $distanceFunction
         |
         |\t\t precision \t recall \t f1_score \t support
         |${distinctLabels.map(l => f"class $l%s \t ${precisions(l)}%1.2f \t ${recalls(l)}%1.2f") mkString "\n"}
         |
         |accuracy   \t$accuracy
         |precision  \t$precision
         |recall     \t$recall
       """.stripMargin
    }

    lazy val distinctLabels: Vector[Int] = labels.distinct.sorted

    lazy val nbDocumentWellClassified: Map[Label, Int] =
      distinctLabels.map { label =>
        label -> (labels zip givenLabels)
          .filter(_._1 == label) // filter for the label
          .count(elt => elt._1 == elt._2)
      }.toMap

    lazy val nbDocumentAttributed: Map[Label, Int] =
      givenLabels.groupBy(l => l).mapValues(_.length)

    lazy val nbDocumentForClass: Map[Label, Int] =
      labels.groupBy(l => l).mapValues(_.length)

    // precision_i = \frac{nb well classified document of class i}{nb document attributed to class i}
    lazy val precisions: Map[Label, Double] =
      nbDocumentWellClassified map tupled { (label, count) =>
        label -> count.toDouble / nbDocumentAttributed.getOrElse(label, 0).toDouble
      }

    // recall_i = \frac{nb well classified document of class i}{nb document of class i}
    lazy val recalls: Map[Label, Double] =
      nbDocumentWellClassified map tupled { (label, count) =>
        label -> count.toDouble / nbDocumentForClass.getOrElse(label, 0).toDouble
      }

    lazy val f1_scores: Vector[(Label, Double)] = ???
    lazy val supports: Vector[(Label, Double)] = ???
    lazy val precision: Double = precisions.values.sum / precisions.size.toDouble
    lazy val recall: Double = recalls.values.sum / recalls.size.toDouble
    lazy val accuracy: Double = (givenLabels zip labels).count(pp => pp._1 == pp._2).toDouble / labels.length.toDouble
  }

  object Result {

    def mkName(k: Int, distanceFunction: String, testSet: Vector[_]): String =
      s"$k$distanceFunction${testSet.length}"

    def mkName(result: Result): String =
      mkName(result.k, result.distanceFunction, result.labels)

    def save(filepath: String, result: Result): Unit = {
      val oss = new ObjectOutputStream(new FileOutputStream(filepath))
      oss.writeObject(result)
      oss.close()
    }

    def loadOrElse(name: String, default: => Result): Result = {
      val file = new File(name)
      if (file.exists()) {
        println(s"Load result for $name")
        val ois = new ObjectInputStream(new FileInputStream(file))
        val result = ois.readObject().asInstanceOf[Result]
        ois.close()
        result
      } else default
    }
  }

  case class ClassifiedImage(givenLabel: Label, label: Label, data: Vector[Int])
  case class LabeledImage(label: Label, data: Vector[Int]) {
    lazy val image: Vector[Vector[Int]] = data.grouped(28).toVector

  }

  object LabeledImage {
    // Assume the label is the first element of the line followed by 28*28 integers
    def fromCSV(file: String): Vector[LabeledImage] = {
      for {
        line <- Source.fromFile(file).getLines()
        cols = line.split(",").map(_.trim)
      } yield LabeledImage(cols(0).toInt, cols.tail.map(_.toInt).toVector)
    }.toVector
  }

  trait DistanceFunction {
    val name: String

    def apply(p1: Vector[Int])(p2: Vector[Int]): Double
  }

  object DistanceFunction {

    // $$d_{euclidian}(p,q) = d_{euclidian}(q,p) = \sqrt{(p_1 - q_1)^2 + (p_2 - q_2)^2 + \dots + (p_n - q_n)^2}$$
    case object EuclidianDistance extends DistanceFunction {
      override val name = "Euclidian"

      override def apply(p1: Vector[Label])(p2: Vector[Label]): Double = Math.sqrt {
        (p1 zip p2).map { pp =>
          val diff = pp._1.toDouble - pp._2.toDouble
          diff * diff
        }.sum
      }
    }

    // $$d_{hamming}(p,q) = \sum_{i=0}^{n-1}(p_i \oplus q_i)$$
    case object HammingDistance extends DistanceFunction {
      override val name: String = "Hamming"

      override def apply(p1: Vector[Label])(p2: Vector[Label]): Double = {
        (p1 zip p2).map(pp => if (pp._1 == pp._2) 1 else 0).sum.toDouble
      }
    }

    // $$d_{manhattan}(p,q) = ||p-q||_1 = \sum_{i=0}^{n-1}|p_i - q_i|$$
    case object ManhattanDistance extends DistanceFunction {
      override val name: String = "Manhattan"

      override def apply(p1: Vector[Label])(p2: Vector[Label]): Double = {
        (p1 zip p2).map(pp => math.abs(pp._1 - pp._2)).sum.toDouble
      }
    }

    // $$d_{minkowski_p}(X,Y) = (\sum_{i=0}^{n-1} |x_i - y_i|^p)^{\frac{1}{p}}$$
    def mkMinkowskiDistance(order: Int): DistanceFunction = {
      new DistanceFunction {
        override val name: String = s"Minkowski$order"

        override def apply(p1: Vector[Label])(p2: Vector[Label]): Double =
          math.pow(
            (p1 zip p2).map(pp => math.pow(math.abs(pp._1 - pp._2).toDouble, order.toDouble)).sum,
            1.0 / order.toDouble
          )
      }
    }
  }

  @SerialVersionUID(101L)
  class DistancesSave(val distances: Vector[(Label, Vector[(Label, Double)])]) extends Serializable {
  }

  object DistancesSave {
    def save(filepath: String, distances: DistancesSave): Unit = {
      val oss = new ObjectOutputStream(new FileOutputStream(filepath))
      oss.writeObject(distances)
      oss.close()
    }

    def load(filepath: String): Vector[(Label, Vector[(Label, Double)])] = {
      val ois = new ObjectInputStream(new FileInputStream(filepath))
      val result = ois.readObject().asInstanceOf[DistancesSave]
      result
    }

    def loadOrElse(name: String, default: => DistancesSave): DistancesSave = {
      val file = new File(name)
      if (file.exists()) {
        println(s"Load distances $name")
        val ois = new ObjectInputStream(new FileInputStream(file))
        val result = ois.readObject().asInstanceOf[DistancesSave]
        ois.close()
        result
      } else default
    }

    def name(testSize: Int, trainSize: Int, distanceFunction: DistanceFunction): String =
      s"${distanceFunction.name}${testSize}x$trainSize"

    def name(distances: Vector[(Label, Vector[(Label, Double)])], distanceFunction: DistanceFunction): String =
      name(distances.length, distances.headOption match {
        case Some(value) => value._2.length
        case None => 0
      }, distanceFunction)
  }

  implicit def distances2Save(distances: Vector[(Label, Vector[(Label, Double)])]): DistancesSave = new DistancesSave(distances)

  implicit def Save2Distances(distances: DistancesSave): Vector[(Label, Vector[(Label, Double)])] = distances.distances
}
