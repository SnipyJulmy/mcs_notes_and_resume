name := "bdi_seed_app_scala"

version := "0.1"

scalaVersion := "2.12.7"

libraryDependencies ++= Seq(
  "org.scalikejdbc" %% "scalikejdbc" % "3.3.+",
  "com.h2database" % "h2" % "1.4.+",
  "ch.qos.logback" % "logback-classic" % "1.2.+"
)