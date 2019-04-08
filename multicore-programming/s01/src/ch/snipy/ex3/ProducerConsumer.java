package ch.snipy.ex3;

public class Runner {

    private static int[] buffer;
    private static int in;
    private static int out;

    public static void main(String[] args) {

        if (args.length != 2) {
            System.out.println("Invalid number of arguments");
            System.exit(0);
        }

        int t = Integer.parseInt(args[0]);
        int n = Integer.parseInt(args[1]);

        Thread[] threads = new Thread[t * 2];

        // create producer and consumer
        for (int i = 0; i < t * 2; i++) {
            // Consumer
            threads[i] = new Thread(() -> {

            });
            // Producer
            threads[i + t] = new Thread(() -> {

            });
        }


    }
}
