name := "PatRec-s02"

version := "0.1"

scalaVersion := "2.12.8"

libraryDependencies ++= Seq(
  "com.github.nscala-time" %% "nscala-time" % "2.22.0",
  "jline" % "jline" % "2.13"
)

resolvers += "Sonatype Releases" at "https://oss.sonatype.org/content/repositories/releases/"
