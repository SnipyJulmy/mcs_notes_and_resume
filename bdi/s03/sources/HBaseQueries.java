
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;

import java.util.Map;
import java.util.NavigableMap;


public class HBaseQueries {

    static Configuration conf = HBaseConfiguration.create();

    public static void main(String[] args) throws Exception {

        conf.set("hbase.zookeeper.quorum", "diufrm210.unifr.ch");
        conf.set("hbase.zookeeper.property.clientPort", "2181");

        Connection connection = ConnectionFactory.createConnection(conf);

        Table table = connection.getTable(TableName.valueOf("weblogs_bdi18_07"));

        //Retrieve only the contents of the Columns: Jan and Feb from the row key: 06.305.307.336|2012

        Get get1 = new Get(Bytes.toBytes("06.305.307.336|2012"));
        Result result1 = table.get(get1);

        String janValue = Bytes.toString(result1.getValue(
                Bytes.toBytes("Months"),
                Bytes.toBytes("Jan")
        ));

        String febValue = Bytes.toString(result1.getValue(
                Bytes.toBytes("Months"),
                Bytes.toBytes("Feb")
        ));

        System.out.printf("Jan : %s, Feb : %s \n", janValue, febValue);

        System.out.println("Part 1 done");

        //Create a new ip and year, and fill in the table with the same values as the row with key: 01.660.70.74|2012

        String newIp = "8.8.8.8";
        String newYear = "1971";
        String rowKey = newIp + "|" + newYear;

        Put put = new Put(Bytes.toBytes(rowKey));

        Get get2 = new Get(Bytes.toBytes("01.660.70.74|2012"));
        Result result2 = table.get(get2);

        NavigableMap<byte[], NavigableMap<byte[], NavigableMap<Long, byte[]>>> map = result2.getMap();

        for (Map.Entry<byte[], NavigableMap<byte[], NavigableMap<Long, byte[]>>> familyEntry : map.entrySet()) {

            byte[] family = familyEntry.getKey();

            for (Map.Entry<byte[], NavigableMap<Long, byte[]>> colEntry : map.get(family).entrySet()) {

                byte[] qualifier = colEntry.getKey();

                for (Map.Entry<Long, byte[]> timestampedValue : map.get(family).get(qualifier).entrySet()) {

                    byte[] value = timestampedValue.getValue();

                    put.addColumn(family, qualifier, value);

                }
            }

        }

        table.put(put);

        System.out.println("Part 2 done");

        //Delete the row with key: 88.88.324.601|2012

        Delete delete = new Delete(Bytes.toBytes("88.88.324.601|2012"));

        table.delete(delete);

        System.out.println("Part 3 done");

        table.close();
        connection.close();

    }

}
