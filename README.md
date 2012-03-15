Playing with Iron.io

iron_worker_producer.rb queues SquareNumberWorker jobs to Iron.io.

SquareNumberWorker squares the number is it passed, and posts a message to the MQ.

iron_mq_consumer.rb reads messages from the MQ.

# To run

1. Open 2 terminal windows
2. In window run:
        ruby iron_worker_producer.rb

3. In the other window run:
        ruby iron_mq_consumer.rb

Now you're cookin' with gas.