package ch.snipy.Ex1;

import java.util.concurrent.locks.ReentrantLock;

public class Ex1ReentrantLock {

    private static int counter = 0;
    private static final ReentrantLock lock = new ReentrantLock();

    // args[0] --> i
    // args[1] --> n
    // args[2] --> m
    public static void main(String[] args) {

        long start = System.currentTimeMillis();

        if (args.length != 3) {
            System.out.println("Number of arguments is incorrect");
            System.exit(0);
        }

        int i = Integer.parseInt(args[0]);
        int n = Integer.parseInt(args[1]);
        int m = Integer.parseInt(args[2]);

        Thread[] threads = new Thread[n + m];

        // Run thread which increment the counter
        for (int j = 0; j < n; j++) {
            threads[j] = new Thread(() -> {
                for (int k = 0; k < i; k++) {
                    lock.lock();
                    int tmp = counter;
                    tmp += 1;
                    counter = tmp;
                    lock.unlock();
                }
            });
            threads[j].start();
        }

        // Run thread which decrement the counter
        for (int j = 0; j < m; j++) {
            threads[n + j] = new Thread(() -> {
                for (int k = 0; k < i; k++) {
                    lock.lock();
                    int tmp = counter;
                    tmp -= 1;
                    counter = tmp;
                    lock.unlock();
                }
            });
            threads[n + j].start();
        }

        for (Thread thread : threads) {
            try {
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
