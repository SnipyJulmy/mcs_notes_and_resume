import scalikejdbc._

import scala.util.Random
import java.time.LocalDate
import java.time.temporal.ChronoUnit.DAYS

object BdiSeeder {
  def main(args: Array[String]): Unit = {

    val dbname = "homework_1_2"

    Class.forName("org.postgresql.Driver")
    val poolSettings = ConnectionPoolSettings(initialSize = 100, maxSize = 100)
    val url = s"jdbc:postgresql://localhost:5432/$dbname"
    val user = "postgres"
    val password = ""

    // create singleton(default) connection pool
    ConnectionPool.singleton(url, user, password, poolSettings)

    implicit val session: AutoSession.type = AutoSession

    // Populate the database

    val nbPaper = 15
    val nbAuthor = 8
    val nbConference = 5
    val maxNumberAuthor = 3
    val acceptedRatio = 0.2
    val citeRatio = 0.5

    val papers = (1 to nbPaper).map { id =>
      Paper(id, randomString, randomString(50))
    }

    val authors = (1 to nbAuthor).map { id =>
      Author(id, randomString, randomEmail, randomString)
    }

    val conferences = (1 to nbConference).map { id =>
      Conference(id, randomString, Random.nextInt)
    }

    val writes = papers.flatMap { p =>
      Random.shuffle(authors).take(Random.nextInt(maxNumberAuthor) + 1).map { a =>
        Writes(p.paperId, a.authorId)
      }
    }

    val submits = papers.map { p =>
      val conf = conferences(Random.nextInt(conferences.length))
      val isAccepted = Random.nextDouble() > acceptedRatio
      Submits(p.paperId, conf.confId, isAccepted, randomDate())
    }

    //
    val cites = for {
      p1 <- papers
      p2 <- papers
      if p1.paperId < p2.paperId
      if Random.nextDouble() > citeRatio
    } yield Cites(p1.paperId, p2.paperId)

    papers.foreach { p =>
      sql"""insert into paper values (${p.paperId},"${p.title}","${p.abs}")""".update().apply()
    }

  }

  def randomString(length: Int): String = Random.alphanumeric take length mkString

  def randomString: String = randomString(10)

  def randomEmail: String = s"$randomString@${randomString(5)}.com"

  def randomDate(from: LocalDate = LocalDate.of(1970, 1, 1), to: LocalDate = LocalDate.of(2018, 3, 10)): LocalDate = {
    val diff = DAYS.between(from, to)
    val random = new Random(System.nanoTime) // You may want a different seed
    from.plusDays(random.nextInt(diff.toInt))
  }
}

case class Paper(paperId: Int, title: String, abs: String)
case class Author(authorId: Int, name: String, email: String, affiliation: String)
case class Conference(confId: Int, name: String, ranking: Int)
case class Writes(authorID: Int, paperID: Int)
case class Submits(paperID: Int, confID: Int, isAccepted: Boolean, date: LocalDate)
case class Cites(paperIDfrom: Int, paperIDto: Int)
