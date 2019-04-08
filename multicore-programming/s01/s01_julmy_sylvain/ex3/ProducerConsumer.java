package ch.snipy.ex3;

public class ProducerConsumer {

    private static int in = 0;
    private static int out = 0;
    private static final Object lockIn = new Object();
    private static final Object lockOut = new Object();

    public static void main(String[] args) {

        if (args.length != 2) {
            System.out.println("Invalid number of arguments");
            System.exit(0);
        }

        int t = Integer.parseInt(args[0]);
        int n = Integer.parseInt(args[1]);

        Thread[] threads = new Thread[t * 2];

        // create producer and consumer
        for (int i = 0; i < t; i++) {

            // Consumer
            threads[i] = new Thread(() -> {
                for (int j = 0; j < 10; j++) {
                    while (true) {
                        if (out != in)
                            break;
                    }

                    safePrintln("consume " + (out));
                    synchronized (lockOut) {
                        out = (out + 1) % n;
                    }
                }
            });

            // Producer
            threads[i + t] = new Thread(() -> {
                for (int j = 0; j < 10; j++) {
                    while (true) {
                        if (((in + 1) % n) != out)
                            break;
                    }

                    safePrintln("produce " + (in));
                    synchronized (lockIn) {
                        in = (in + 1) % n;
                    }
                }
            });
        }


        for (Thread thread : threads) {
            thread.start();
        }

        try {
            for (Thread thread : threads) {
                thread.join();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    public static void safePrintln(String s) {
        synchronized (System.out) {
            System.out.println(s);
        }
    }
}