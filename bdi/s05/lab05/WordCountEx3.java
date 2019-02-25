import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

public class WordCountEx3 {

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "word count");
        job.setJar("WordCountEx3.jar");
        job.setJarByClass(WordCountEx3.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setReducerClass(IntSumReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }

    public static class TokenizerMapper extends Mapper<Object, Text, Text, IntWritable> {
        private final static IntWritable one = new IntWritable(1);
        public HashMap<String, String> htmlEntities;
        private Text word = new Text();

        public void map(
                Object key,
                Text value,
                Context context
        ) throws IOException, InterruptedException {

            initHashMap();
            String value2 = value.toString();
            value2 = value2.replaceAll("[,\\.:()\"@?!]", "").replaceAll("&rdquo;", "").toLowerCase();
            for (Map.Entry<String, String> entry : htmlEntities.entrySet()) {
                String key1 = entry.getKey();
                String value1 = entry.getValue();
                value2 = value2.replaceAll(key1, value1);
            }
            StringTokenizer itr = new StringTokenizer(value2);
            while (itr.hasMoreTokens()) {
                word.set(itr.nextToken());
                context.write(word, one);
            }
        }

        public void initHashMap() {
            htmlEntities = new HashMap<String, String>();
            htmlEntities.put("&lt;", "<"); htmlEntities.put("&gt;", ">");
            htmlEntities.put("&amp;", "&"); htmlEntities.put("&quot;", "\"");
            htmlEntities.put("&agrave;", "à"); htmlEntities.put("&Agrave;", "À");
            htmlEntities.put("&acirc;", "â"); htmlEntities.put("&auml;", "ä");
            htmlEntities.put("&Auml;", "Ä"); htmlEntities.put("&Acirc;", "Â");
            htmlEntities.put("&aring;", "å"); htmlEntities.put("&Aring;", "Å");
            htmlEntities.put("&aelig;", "æ"); htmlEntities.put("&AElig;", "Æ");
            htmlEntities.put("&ccedil;", "ç"); htmlEntities.put("&Ccedil;", "Ç");
            htmlEntities.put("&eacute;", "é"); htmlEntities.put("&Eacute;", "É");
            htmlEntities.put("&egrave;", "è"); htmlEntities.put("&Egrave;", "È");
            htmlEntities.put("&ecirc;", "ê"); htmlEntities.put("&Ecirc;", "Ê");
            htmlEntities.put("&euml;", "ë"); htmlEntities.put("&Euml;", "Ë");
            htmlEntities.put("&iuml;", "ï"); htmlEntities.put("&Iuml;", "Ï");
            htmlEntities.put("&ocirc;", "ô"); htmlEntities.put("&Ocirc;", "Ô");
            htmlEntities.put("&ouml;", "ö"); htmlEntities.put("&Ouml;", "Ö");
            htmlEntities.put("&oslash;", "ø"); htmlEntities.put("&Oslash;", "Ø");
            htmlEntities.put("&szlig;", "ß"); htmlEntities.put("&ugrave;", "ù");
            htmlEntities.put("&Ugrave;", "Ù"); htmlEntities.put("&ucirc;", "û");
            htmlEntities.put("&Ucirc;", "Û"); htmlEntities.put("&uuml;", "ü");
            htmlEntities.put("&Uuml;", "Ü"); htmlEntities.put("&nbsp;", " ");
            htmlEntities.put("&copy;", "\u00a9"); htmlEntities.put("&reg;", "\u00ae");
            htmlEntities.put("&euro;", "\u20a0"); htmlEntities.put("&rsquo;", "'");
        }
    }

    public static class IntSumReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
        private IntWritable result = new IntWritable();

        public void reduce(
                Text key,
                Iterable<IntWritable> values,
                Context context
        ) throws IOException, InterruptedException {

            int sum = 0;
            for (IntWritable val : values) {
                sum += val.get();
            }
            result.set(sum);
            context.write(key, result);
        }
    }
}
