#! /bin/bash

# usage :
# 1st argument is the name of the run
# 2nd argument is the path of the java file
# 3nd argument is the path for the input files
# example ./run.sh ex1 WordCountEx1.java /bdi_2018/data/NYTimes_articles

experiment=$1
javaFile=$2
inPath=$3

filename=$(basename -- "$javaFile")
filename="${filename%.*}"
classFile="$filename.class"
jarFile="$filename.jar"

# for telegram
apiToken="651009095:AAHTl2_1LEyJNAVsuxtdhCzF5jIiGnDAs0Y"
chatId="23817760"

# export java...
export JAVA_HOME=~/bundle/java_7
export PATH=$PATH:${JAVA_HOME}/bin

# run experiment
javac -classpath `bin/hadoop classpath` ${javaFile}
jar cf ${jarFile} ${filename}*class
bin/hadoop jar ${jarFile} ${filename} ${inPath} /bdi_2018/bdi18_07/${experiment}_output
bin/hadoop fs -copyToLocal /bdi_2018/bdi18_07/${experiment}_output ~/${experiment}_output

# uncomment to remove the output from HDFS
# bin/hadoop fs -rm -r -skipTrash /bdi_2018/bdi18_07/output

send() {
    curl -s \
    -X POST \
    https://api.telegram.org/bot${apiToken}/sendMessage \
    -d text="$1" \
    -d chat_id=${chatId}
}

rm *.jar
rm *.class

send "experiment $experiment done"