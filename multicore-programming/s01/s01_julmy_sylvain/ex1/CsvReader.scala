package ch.snipy.ex1

import com.github.tototoshi.csv._

object CsvReader extends App {
  val files = 1000000 to 10000000 by 1000000

  val ns = for {
    n <- files
    filename = s"results/result_$n.csv"
    data = CSVReader.open(filename).all()
    n1 = data(1)(3)
    n2 = data(2)(3)
    n3 = data(3)(3)
    n4 = data(4)(3)
  } yield (n1, n2, n3, n4)

  val sep = "\t"
  println(ns.map(_._1).mkString(sep))
  println(ns.map(_._2).mkString(sep))
  println(ns.map(_._3).mkString(sep))
  println(ns.map(_._4).mkString(sep))

}
