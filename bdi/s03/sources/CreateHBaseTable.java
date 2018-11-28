import org.apache.hadoop.hbase.*;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;

public class CreateHBaseTable {

    static Configuration conf = HBaseConfiguration.create();

    public static void main(String[] args) throws Exception {

        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

        conf.set("hbase.zookeeper.quorum", "diufrm210.unifr.ch");
        conf.set("hbase.zookeeper.property.clientPort", "2181");

        Connection connection = ConnectionFactory.createConnection(conf);

        String tableName = "weblogs_bdi18_07";
        // Connect to Hbase and create the table
        try {
            Admin hAdmin = connection.getAdmin();
            HTableDescriptor hTableDesc = new HTableDescriptor(
                    TableName.valueOf(tableName));
            hTableDesc.addFamily(new HColumnDescriptor("Months"));
            hTableDesc.addFamily(new HColumnDescriptor("Statistics"));
            System.out.println("Creating Table...");
            hAdmin.createTable(hTableDesc);
            System.out.println("Table created Successfully...");

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Connection to the table");
        Table table = connection.getTable(TableName.valueOf(tableName));

        try {

            System.out.println("Insert the datas");
            // Reading the dataset from HDFS
            Path path = new Path("/bdi_2018/bdi18_07/weblogs_hbase.txt");
            FileSystem fileSystem = FileSystem.get(new Configuration());
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(fileSystem.open(path)));

            String line = bufferedReader.readLine();
            while (line != null) {

                String[] elements = line.split("\t");
                assert elements.length == 13;

                String rowKey = elements[0];

                Put put = new Put(Bytes.toBytes(rowKey));

                int totalNumberOfVisit = 0;

                for (int i = 1; i < elements.length; i++) {
                    String key = months[i - 1];
                    String valueStr = elements[i];
                    int value = Integer.parseInt(valueStr);
                    if (value == 0)
                        continue;
                    totalNumberOfVisit += value;
                    put.addColumn(
                            Bytes.toBytes("Months"),
                            Bytes.toBytes(key),
                            Bytes.toBytes(valueStr)
                    );
                }

                put.addColumn(
                        Bytes.toBytes("Statistics"),
                        Bytes.toBytes("Active"),
                        Bytes.toBytes(
                                totalNumberOfVisit > 20 ?
                                        "1" :
                                        "0"
                        )
                );

                table.put(put);

                line = bufferedReader.readLine();
            }

            System.out.println("Done");
            table.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
