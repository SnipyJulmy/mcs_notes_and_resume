package ex5;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;


public class InOutDegreeCounter {

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();

        Job job = Job.getInstance(conf, "in and out degree count");

        job.setJar("ex5.InOutDegreeCounter.jar");
        job.setJarByClass(InOutDegreeCounter.class);

        job.setMapperClass(TokenizerMapper.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setReducerClass(IntSumReducer.class);

        // Map output
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntTriple.class);

        // Global output
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntTriple.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }

    // Test if s is a valid URI or not
    private static boolean isValidURI(String s) {
        try {
            URI uri = new URI(s);
            return true;
        } catch (URISyntaxException e) {
            return false;
        }
    }

    public static class TokenizerMapper extends Mapper<Object, Text, Text, IntTriple> {

        private Text word = new Text();

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {

            String[] values = value.toString().split("\t");
            String subject = values[0];
            String predicate = values[1];
            String object = values[2];
            String provenance = values[3];

            word.set(subject);
            context.write(word, new IntTriple(isValidURI(object) ? 0 : 1, 0, 1));
            if (isValidURI(object)) {
                word.set(object);
                context.write(word, new IntTriple(0, 1, 0));
            }
        }
    }

    public static class IntSumReducer extends Reducer<Text, IntTriple, Text, IntTriple> {

        public void reduce(Text key, Iterable<IntTriple> values, Context context)
                throws IOException, InterruptedException {

            int sumLiteral = 0, sumIn = 0, sumOut = 0;

            for (IntTriple triple : values) {
                sumLiteral += triple.a.get();
                sumIn += triple.b.get();
                sumOut += triple.c.get();
            }

            if (sumLiteral >= 10) {
                context.write(key, new IntTriple(sumLiteral, sumIn, sumOut));
            }
        }
    }

    static class IntTriple implements Writable {

        private IntWritable a;
        private IntWritable b;
        private IntWritable c;

        public IntTriple() {
            set(
                    new IntWritable(0),
                    new IntWritable(0),
                    new IntWritable(0)
            );
        }

        public IntTriple(IntWritable a, IntWritable b, IntWritable c) {
            this.a = a;
            this.b = b;
            this.c = c;
        }

        public IntTriple(int a, int b, int c) {
            this.a = new IntWritable(a);
            this.b = new IntWritable(b);
            this.c = new IntWritable(c);
        }

        public int compareTo(IntTriple that) {
            int cmp = this.a.compareTo(that.a);
            if (cmp != 0)
                return cmp;
            cmp = this.b.compareTo(that.b);
            if (cmp != 0)
                return cmp;
            return this.c.compareTo(that.c);
        }

        public void set(IntWritable a, IntWritable b, IntWritable c) {
            this.a = a;
            this.b = b;
            this.c = c;
        }

        public void write(DataOutput dataOutput) throws IOException {
            a.write(dataOutput);
            b.write(dataOutput);
            c.write(dataOutput);
        }

        public void readFields(DataInput dataInput) throws IOException {
            a.readFields(dataInput);
            b.readFields(dataInput);
            c.readFields(dataInput);
        }

        @Override
        public int hashCode() {
            return a.hashCode() * 163 * 163 + b.hashCode() * 163 + c.hashCode();
        }

        @Override
        public boolean equals(Object obj) {
            if (obj instanceof IntTriple) {
                IntTriple that = (IntTriple) obj;
                return this.a.equals(that.a) &&
                        this.b.equals(that.b) &&
                        this.c.equals(that.c);
            }
            return false;
        }

        @Override
        public String toString() {
            return String.format("(%d,%d,%d)", a.get(), b.get(), c.get());
        }
    }
}
