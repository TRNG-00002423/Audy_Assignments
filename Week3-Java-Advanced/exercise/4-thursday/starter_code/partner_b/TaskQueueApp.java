import java.util.PriorityQueue;
import java.util.Queue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/** Partner B — drain PriorityQueue in priority order. */
public class TaskQueueApp {
    private static final Logger LOGGER = LoggerFactory.getLogger("pair.b.tasks");

    public static void main(String[] args) {
        LOGGER.info("TaskQueueApp started");

        Queue<Task> q = new PriorityQueue<>();
        // TODO: offer tasks out of order, poll and print, peek demo
        q.add(new Task(1, "walk dog"));
        q.add(new Task(3, "cooking"));
        q.add(new Task(2, "guitar"));

        if (q.isEmpty()) {
            LOGGER.warn("Task queue is empty; nothing to process");
            return;
        }

        System.out.println(q.peek());

        while (!q.isEmpty()) {
            Task task = q.poll();
            LOGGER.debug("Drained task: {}", task);
            System.out.println(task);
        }

        LOGGER.warn("Task queue drained completely");
        LOGGER.info("TaskQueueApp finished");
    }
}
