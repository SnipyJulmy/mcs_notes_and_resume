import pb.ProgressBar

import scala.annotation.tailrec
import scala.collection.mutable
import scala.io.Source
import scala.util.Random

object Main extends App {

  // Config
  val trainFile = "train.csv"

  println(s"Load training set")
  val points: List[Point] = {
    val ps = for {
      line <- Source.fromFile(trainFile).getLines().take(100)
      cols = line.split(",").map(_.trim)
      pos = cols
        .tail // drop the first column
        .map(_.toDouble / 255.0) // reduce the complexity
        .toVector
    } yield Point(pos)
    ps.toList
  }

  val kMeans = new KMeans(10, points)
  kMeans.classify(Iteration(10))
}

class KMeans(k: Int, data: List[Point]) {

  // create the initial clusters
  val clusters: List[Cluster] =
    (for (i <- 0 to k)
      yield new Cluster(i, mutable.Queue(), data.apply(Random.nextInt(data.length)))) (collection.breakOut)

  /*  For each point from the data
   *  - find the closest cluster based on his center
   */
  def classify(terminationCriteria: TerminationCriteria): Unit = {

    var pb = new ProgressBar(terminationCriteria.asInstanceOf[Iteration].n * data.length)

    @tailrec
    def step(ls: List[Point]): Unit = ls match {
      case Nil =>
      case p :: ps =>
        pb += 1
        val cluster = closestCluster(p)
        cluster.points += p
        step(ps)
    }

    while (!terminationCriteria.done) {
      terminationCriteria.step

      // clear the centroid
      clusters.foreach(_.clear())

      // process the data
      step(data)

      // recompute the centroid
      clusters.foreach { c =>
        c.center = c.centroid
      }
    }

    println()

    clusters.foreach { c =>
      println(f"error for cluster ${c.id}%2s : ${c.error}%.2f")
    }
  }

  def closestCluster(point: Point): Cluster = clusters.minBy(c => point <-> c.centroid)
}

trait TerminationCriteria {
  def step(): Unit
  def done: Boolean
}
case class Iteration(var n: Int) extends TerminationCriteria {
  override def step(): Unit = n -= 1
  override def done: Boolean = n <= 0
}

class Cluster(val id: Int, val points: mutable.Queue[Point], var center: Point) {
  def clear(): Unit = points.clear()

  def add(point: Point): Unit = points += point

  // compute the centroid of this cluster
  def centroid: Point =
    if (points.isEmpty) center
    else points.reduce {
      (p1, p2) =>
        Point(
          (p1.coordinates zip p2.coordinates)
            .map(pp => (pp._1 + pp._2) / points.length.toDouble)
        )
    }

  // compute the error to the center of the cluster
  def error: Double = points.map(_ <-> center).sum / points.length.toDouble
}

case class Point(coordinates: Vector[Double]) {
  def <->(that: Point): Double = distance(that)

  def distance(that: Point): Double = Distances.EuclidianDistance(this, that)

  // compute the distance from the origin
  def distance(): Double = Distances.EuclidianDistance(this, Point(coordinates.map(_ => 0.0)))
}

object Distances {
  def EuclidianDistance(a: Point, b: Point): Double = {
    (a.coordinates zip b.coordinates).map { pp =>
      val diff = pp._1 - pp._2
      diff * diff
    }.sum
  }
}