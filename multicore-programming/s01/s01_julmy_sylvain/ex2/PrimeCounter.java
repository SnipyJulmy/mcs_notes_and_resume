package ch.snipy.ex2;

import static ch.snipy.ex2.Config.MAX_VALUE;

public class PrimeCounter {

    private static final Object lock = new Object();
    private static int counter;

    private static int nextNumber() {
        int res;
        synchronized (lock) {
            res = counter;
            counter++;
        }
        return res;
    }

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Invalid number of arguments");
            System.exit(0);
        }

        int nbThreads = Integer.parseInt(args[0]);

        counter = 0;

        Thread[] threads = new Thread[nbThreads];

        for (int i = 1; i <= nbThreads; i++) {
            threads[i - 1] = new Thread(() -> {
                for (int n = nextNumber(); n < MAX_VALUE; n = nextNumber()) {
                    //noinspection ResultOfMethodCallIgnored
                    isPrime(n);
                }
            });
        }

        long start = System.nanoTime();
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
        long end = System.nanoTime();
        System.out.println("time : " + ((end - start) / 1_000_000) + "ms");
    }

    @SuppressWarnings("UnusedReturnValue")
    private static boolean isPrime(int n) {
        if (n < 2) return false;
        if (n == 2 || n == 3) return true;
        if (n % 2 == 0 || n % 3 == 0) return false;
        long sqrt = (long) Math.sqrt(n) + 1;
        for (long i = 6L; i < sqrt; i += 6) {
            if (n % (i - 1) == 0 || n % (i + 1) == 0) return false;
        }
        return true;
    }
}
