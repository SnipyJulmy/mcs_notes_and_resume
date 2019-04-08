package ch.snipy.ex2

import scala.language.postfixOps

object Main extends App {
  val nbProcessToTest = List(1, 2, 4, 8)

  for (n <- nbProcessToTest) {
    val args: Array[String] = Array(s"$n")
    println(s"run range with   n = $n")
    PrimeRange.main(args)
    println(s"run counter with n = $n")
    PrimeCounter.main(args)
  }
}
