/****************************************************************/
/* CyclicBarrier Example */
/* ~~~~~~~~~~~~~~~~~~~~~ */
/* Parallel processing of a BMP test image
 * General indications:
 *  -- main thread only starts worker threads and waits for them to finish
 *  -- 2 types of worker threads: a master thread and more workers
 *  -- master thread (id 0): loads the shared BMP image, waits for all workers to start (on barrier1),
 *  									waits for all workers to finish processing (on barrier2), and aggregates and outputs the result
 *  -- worker threads: sync with the master, get their part of the image, process it and return the result
 *  									in a shared array on the position given by their id
 **/


import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

//////////////////////////////////////////////////////////////////////////////////////////
////////// HELPER FUNCTIONS (_NO_ need to modify) ////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
public class ImageAnalysis {
    private static final int NUM_THREADS = 9;
    private static BufferedImage img = null;
    private static int[] localBlackPixels = new int[NUM_THREADS - 1];

    static int analyseImage(BufferedImage img, int height, int w_start, int w_end) {
        int blackPixels = 0;
        int rgb, red, green, blue;

        int index = (w_start == 0) ? 1 : w_start;

        for (int h = 1; h < height; h++) {
            for (int w = index; w < w_end; w++) {
                rgb = img.getRGB(w, h);
                red = (rgb >> 16) & 0x000000FF;
                green = (rgb >> 8) & 0x000000FF;
                blue = (rgb) & 0x000000FF;

                if (red == 0 && green == 0 && blue == 0)
                    blackPixels++;
            }
        }

        return blackPixels;
    }

    static BufferedImage loadImage() {
        BufferedImage img = null;
        try {
            img = ImageIO.read(new File("test.bmp"));
        } catch (IOException e) {

        }
        return img;
    }
//////////////////////////////////////////////////////////////////////////////////////////
////////// END HELPER FUNCTIONS /////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////////
////////// MAIN  /////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
    public static void main(String[] args) {

        // HERE: define and initialize an array of NUM_THREADS threads
        Thread[] threads = new Thread[NUM_THREADS];

        // HERE: define and initialize 2 cyclic barriers for NUM_THREADS
        CyclicBarrier barrier1 = new CyclicBarrier(NUM_THREADS);
        CyclicBarrier barrier2 = new CyclicBarrier(NUM_THREADS);

        // start threads one by one
        for (int i = 0; i < NUM_THREADS; i++) {
            //HERE: Thread constructor -- will receive as parameter i (will call it the _id_ of the thread), barrier 1 and barrier 2
            threads[i] = new WorkerThread(i, barrier1, barrier2);

            //HERE: start thread
            threads[i].start();
        }

        try {
            for (Thread thread : threads)
                thread.join();
        } catch (InterruptedException e) {
            System.err.println("Error in join()");
        }
    }
//////////////////////////////////////////////////////////////////////////////////////////
////////// END WORKER THREAD CLASS  /////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////////
////////// WORKER THREAD CLASS  /////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
    static class WorkerThread extends Thread {

        private final int id;
        private final CyclicBarrier barrier1;
        private final CyclicBarrier barrier2;

        public WorkerThread(int id, CyclicBarrier barrier1, CyclicBarrier barrier2) {
            this.id = id;
            this.barrier1 = barrier1;
            this.barrier2 = barrier2;
        }

        @Override
        public void run() {
            /* we handle separately the master thread (id 0) */
            if (id == 0) {
                // only one thread loads the image
                img = loadImage();

                try {
                    // HERE: wait on the first barrier
                    barrier1.await();

                    // HERE: wait on the second barrier	for all workers to finish reporting their local values
                    barrier2.await();
                } catch (InterruptedException | BrokenBarrierException e) {
                    e.printStackTrace();
                }

                // aggregation and output of results follows
                int totalBlackPixels = 0;
                for (int i = 0; i < (NUM_THREADS - 1); i++)
                    totalBlackPixels += localBlackPixels[i];
                System.out.println("Total black pixels: " + totalBlackPixels);
            }
            /*  end of master thread */

            /*  beginning of workers (all of them do the same thing: process the image) */
            else {
                // HERE: wait on the first barrier: we must sync with master thread so that we all have the same input image
                try {
                    barrier1.await();

                    // computation of the new parameters for each slice follows
                    int height = img.getHeight();
                    int width = img.getWidth() / (NUM_THREADS - 1);
                    int w_start = (id - 1) * width;
                    int w_end = w_start + width;

                    // we analyse our slice of the image locally
                    // HERE: use method analyseImage(BufferedImage,int,int,int) to compute the number of black pixels
                    // 				for this slice
                    int nbBlackPixel = analyseImage(img, height, w_start, w_end);

                    // HERE: set the corresponding element of the shared array (position given by id-1)
                    localBlackPixels[id - 1] = nbBlackPixel;

                    // HERE: final sync with the master, second barrier
                    barrier2.await();
                } catch (InterruptedException | BrokenBarrierException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
