ExtractTweetTextLocal:
	bin/spark-submit \
	--master local[*] \
	--class xi.examples.ExtractTweetText \
	~/SampleCode-assembly-1.0.jar \
	file:///home/alberto/mock_tweets \
	file:///home/alberto/mock_tweets_result.tsv


ExtractTweetText:
		bin/spark-submit \
		--master yarn \
		--deploy-mode cluster \
		--num-executors 50 \
		--driver-memory 1g \
		--executor-memory 1g \
		--class xi.examples.ExtractTweetText \
		~/SampleCode-assembly-1.0.jar \
		/user/ruslan/ruslan/all_tweets_no_gps \
		allTweetsText_15Feb_1.gz


WordCountLocal:
	bin/spark-submit \
	--master local[*] \
	--class xi.examples.HelloSpark \
	~/bundle/spark2/SampleCode-assembly-1.0-ex1.jar \
	file:///home/bdi18_07/bundle/spark2/tweet_sample_raw_data.txt \
	file:///home/bdi18_07/bundle/spark2/spark_ex1


WordCount:
	bin/spark-submit \
    --master yarn \
    --deploy-mode cluster \
    --num-executors 5 \
    --driver-memory 1g \
    --executor-memory 1g \
    --class xi.examples.HelloSpark \
	~/bundle/spark2/SampleCode-assembly-1.0-ex1.jar \
	/bdi_2018/bdi18_07/tweet_sample_raw_data.txt \
	/bdi_2018/bdi18_07/spark_ex1


HashTagCountLocal:
	bin/spark-submit \
	--master local[*] \
	--class xi.examples.HashTagCounter \
	~/bundle/spark2/SampleCode-assembly-1.0-ex2.jar \
	file:///home/bdi18_07/bundle/spark2/tweet_sample_raw_data.txt \
	file:///home/bdi18_07/bundle/spark2/spark_ex2


HashTagCount:
	bin/spark-submit \
    --master yarn \
    --deploy-mode cluster \
    --num-executors 5 \
    --driver-memory 1g \
    --executor-memory 1g \
    --class xi.examples.HashTagCounter \
	~/bundle/spark2/SampleCode-assembly-1.0-ex2.jar \
	/bdi_2018/bdi18_07/tweet_sample_raw_data.txt \
	/bdi_2018/bdi18_07/spark_ex2


Cache:
	bin/spark-submit \
    --master yarn \
    --deploy-mode cluster \
    --num-executors 50 \
    --driver-memory 1g \
    --executor-memory 1g \
    --class xi.examples.Caching \
    ~/SampleCode-assembly-1.0.jar \
    /user/ruslan/ruslan/all_tweets_no_gps \
    tweetsICare/tweetText


Shell:
	bin/spark-shell \
	--master yarn \
	--deploy-mode client \
	--num-executors 3 \
	--driver-memory 1g \
	--executor-memory 1g

ToParquet:
	bin/spark-submit \
	--master yarn \
	--deploy-mode client \
	--num-executors 50 \
	--driver-memory 1g \
	--executor-memory 1g \
	--class xi.examples.ToParquet \
	~/SampleCode-assembly-1.0.jar \
	/user/ruslan/ruslan/all_tweets_no_gps \
	allTweetsText_15Feb_1.parquet