import java.io.File

import breeze.linalg._
import breeze.stats._

import scala.annotation.tailrec

object Main extends App {

  // Config
  val trainFile = new File("train.csv")
  assert(trainFile.exists())

  // each value is between 0 and 1
  println(s"load points...")
  val points = csvread(trainFile)(0 until 10000, 1 to -1) // 255.0
  println(s"loaded ${points.rows} points")

  val ks = List(5, 7, 9, 10, 12, 15)
  for (k <- ks) {
    println(s"run for k = $k")
    new KMeans(k, points).run()
    println()
  }
}

/*
 *  Kmeans algorithm
 *
 */
class KMeans(val k: Int, val points: DenseMatrix[Double]) {

  // initial centroid
  lazy val initialCentroid: List[Centroid] = {
    (1 to k).map(id =>
      Centroid(id, points(scala.util.Random.nextInt(points.rows), ::).t)
    ).toList
  }

  lazy val distances: DenseMatrix[Double] = {
    dist(points.t, points.t)
  }

  lazy val distancesFlat: DenseVector[Double] = {
    distances.toDenseVector
  }

  lazy val sortedIdx: IndexedSeq[Int] = {
    argsort(distancesFlat)
  }

  private def dist(a: DenseVector[Double], b: DenseVector[Double]): Double = norm(a - b)

  private def dist(x1: DenseMatrix[Double], x2: DenseMatrix[Double]): DenseMatrix[Double] = {
    val t1 = -2.0 * (x1.t * x2)
    val t2 = t1(*, ::) + sum(x2 *:* x2, Axis._0).t
    t2(::, *) + sum(x1 *:* x1, Axis._0).t
  }

  private def dist(c1: Centroid, c2: Centroid, labels: DenseVector[Int]): Double = {
    assert(c1.id != c2.id)
    val v1 = points(labels :== c1.id, ::).toDenseMatrix
    val v2 = points(labels :== c2.id, ::).toDenseMatrix
    if(v1.activeSize == 0 || v2.activeSize == 0) Double.MaxValue
    else min(dist(v1.t, v2.t))
  }

  private def assign(centroids: List[Centroid]): DenseVector[Int] = {
    /* assign each point to its closest centroid */
    points(*, ::).map { row =>
      val d = centroids.map { c =>
        (c, dist(c.coordinates, row))
      }
      d.minBy(_._2)._1.id
    }
  }

  private def recomputeCentroid(centroids: List[Centroid], labels: DenseVector[Int]): List[Centroid] =
    centroids.map { c =>
      // indexing search
      val values = points(labels :== c.id, ::).toDenseMatrix
      val center: DenseVector[Double] = mean(values(::, *)).t
      Centroid(c.id, center)
    }

  private def diameter(centroid: Centroid, labels: DenseVector[Int]): Double = {
    val values = points(labels :== centroid.id, ::).toDenseMatrix
    max(dist(values.t, values.t))
  }

  private def deltaMax(centroids: List[Centroid], labels: DenseVector[Int]): Double = {
    centroids.map(c => diameter(c, labels)).max
  }

  private def dunnIndex(centroids: List[Centroid], labels: DenseVector[Int]): Double = {
    val deltaM = deltaMax(centroids, labels)
    (for {
      c1 <- centroids
      c2 <- centroids
      if c1.id != c2.id
      d = dist(c1, c2, labels)
    } yield d).min / deltaM
  }

  private def cIndex(centroids: List[Centroid], labels: DenseVector[Int]): Double = {
    val gamma: Double = sum(unique(labels).map { c =>
      val values = points(labels :== c, ::).toDenseMatrix
      sum(dist(values.t, values.t))
    }) / 2.0

    val alpha: Int = centroids.map { c =>
      val a = (labels :== c.id).activeSize
      a * (a - 1) / 2
    }.sum

    val minA: Double = sum(distancesFlat(sortedIdx.take(alpha * 2))) / 2.0
    val maxA: Double = sum(distancesFlat(sortedIdx.takeRight(alpha * 2))) / 2.0
    (gamma - minA) / (maxA - minA)
  }

  def run(): DenseVector[Int] = {
    @tailrec
    def inner(oldLabels: DenseVector[Int], centroids: List[Centroid]): DenseVector[Int] = {
      val labels = assign(centroids)
      if (oldLabels == labels) {
        println(s"c-index    : ${cIndex(centroids, labels)}")
        println(s"dunn-index : ${dunnIndex(centroids, labels)}")
        oldLabels
      }
      else // recompute the centroid
        inner(labels, recomputeCentroid(centroids, labels))
    }

    inner(DenseVector.zeros(points.rows), initialCentroid)
  }

  case class Centroid(id: Int, coordinates: DenseVector[Double])
}
