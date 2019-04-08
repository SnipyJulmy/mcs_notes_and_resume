package ch.snipy.ex1

import java.io._

import scala.Function.tupled
import scala.annotation.tailrec

object Main extends App {

  /* Config */
  val outputFilePath = "./result.txt"
  val outputFile = new File(outputFilePath)

  val iToTest = (3 to 7).map(math.pow(10, _).toInt).flatMap(i => (1 to 9).map(i * _).toList)
  val nmToTest = List(1, 2, 4, 8)

  if (!outputFile.exists())
    mkResults()

  val outputDir = mkDir("./results")

  // parse the file
  val results = processLines(scala.io.Source.fromFile(outputFile).getLines().toList)

  results.groupBy(_.i) foreach tupled { (i, rs) =>
    // create 1 file per i to test
    val outputFile = mkFile(s"./results/result_$i.csv")
    val bw = new BufferedWriter(new FileWriter(outputFile))
    // we iterate over the number of cpu (n and m) --> row
    // and then locktype --> col

    bw.write {
      s",nosync, sync, lock\n"
    }

    for {
      row <- nmToTest
    } {
      val (r1, r2, r3) = {
        val ls = rs.filter(r => r.n == row)
        (ls.find(l => l.lockType == LockType.NoSync).get,
          ls.find(l => l.lockType == LockType.Sync).get,
          ls.find(l => l.lockType == LockType.Lock).get)
      }
      bw.write {
        s"$row, ${r1.time}, ${r2.time}, ${r3.time} \n"
      }
    }

    bw.flush()
    bw.close()
  }


  object LockType extends Enumeration {
    val Sync, NoSync, Lock = Value
  }

  case class Result(i: Int, n: Int, m: Int, counter: Int, time: Long, lockType: LockType.Value)

  @tailrec
  def processLines(lines: List[String], acc: List[Result] = Nil): List[Result] = lines match {
    case Nil => acc
    case l1 :: l2 :: l3 :: xs =>

      val lockType = l1.split(":")(0).trim match {
        case "sync" => LockType.Sync
        case "nosync" => LockType.NoSync
        case "lock" => LockType.Lock
      }
      val data = l1.split(":")(1).trim.split(",")
      val (i, n, m) = (data(0).toInt, data(1).toInt, data(2).toInt)
      val counter = l2.split(":")(1).trim.toInt
      val time = l3.split(":")(1).trim.toLong
      val res: Result = Result(i, n, m, counter, time, lockType)
      processLines(xs, res :: acc)
  }

  def mkFile(path: String, overwrite: Boolean = true): File = {
    val file = new File(path)
    if (file.exists())
      if (overwrite)
        if (!file.delete()) {
          println(s"can't remove file $path")
          System.exit(0)
        }
    assert(!file.exists())
    if (!file.createNewFile()) {
      println(s"can't create file $path")
      System.exit(0)
    }
    file
  }

  def mkDir(path: String, overwrite: Boolean = true): File = {
    val dir = new File(path)
    if (dir.exists())
      if (dir.isDirectory) {
        if (overwrite)
          rmDir(dir)
      } else dir.delete()
    if (!dir.mkdirs()) {
      println(s"can't create file $path")
      System.exit(0)
    }
    dir
  }

  def rmDir(dir: File): Unit = {
    for (file <- dir.listFiles()) {
      if (file.isDirectory)
        rmDir(file)
      else
        file.delete()
    }
    dir.delete()
  }

  def mkResults(): Unit = {
    // replace std output
    val out = System.out
    System.setOut(new PrintStream(new BufferedOutputStream(new FileOutputStream(outputFile)), true))

    for {
      i <- iToTest
      n <- nmToTest
      m = n
    } {
      val args: Array[String] = Array(
        i.toString,
        n.toString,
        m.toString
      )
      println(s"nosync : $i,$m,$n")
      Ex1NoSync.main(args)
      println(s"sync : $i,$m,$n")
      Ex1Sync.main(args)
      println(s"lock : $i,$m,$n")
      Ex1ReentrantLock.main(args)
    }
    System.setOut(out)
  }
}
