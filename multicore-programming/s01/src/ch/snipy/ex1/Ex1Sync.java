package ch.snipy.ex1;

public class Ex1Sync {

    private static final Object lock = new Object();
    private static int counter = 0;

    // args[0] --> i
    // args[1] --> n
    // args[2] --> m
    public static void main(String[] args) {


        if (args.length < 3) {
            System.out.println("Number of arguments is incorrect");
            System.exit(0);
        }

        final int i = Integer.parseInt(args[0]);
        final int n = Integer.parseInt(args[1]);
        final int m = Integer.parseInt(args[2]);

        Thread[] threads = new Thread[n + m];

        // Run thread which increment the counter
        for (int j = 0; j < n; j++) {
            threads[j] = new Thread(() -> {
                for (int k = 0; k < i; k++) {
                    synchronized (lock) {
                        int tmp = counter;
                        tmp += 1;
                        counter = tmp;
                    }
                }
            });
        }

        // Run thread which decrement the counter
        for (int j = 0; j < m; j++) {
            threads[n + j] = new Thread(() -> {
                for (int k = 0; k < i; k++) {
                    synchronized (lock) {
                        int tmp = counter;
                        tmp -= 1;
                        counter = tmp;
                    }
                }
            });
        }

        long start = System.currentTimeMillis();
        for (Thread thread : threads) {
            try {
                thread.start();
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        long end = System.currentTimeMillis();

        System.out.println("counter : " + counter);
        System.out.println("time : " + (end - start));

        // assertion at the end
        assert (n * i - m * i == counter);
        assert (n != m || counter == 0);
    }
}
