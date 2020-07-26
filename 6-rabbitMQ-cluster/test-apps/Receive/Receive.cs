using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;

/**
If you want to save only 'warning' and 'error' (and not 'info') log messages to a file, just open a console and type:

dotnet run warning error > logs_from_rabbit.log
If you'd like to see all the log messages on your screen, open a new terminal and do:

dotnet run info warning error
# => [*] Waiting for logs. To exit press CTRL+C

*/
class Receive
{
    public static void Main(string[] args)
    {
        var factory = new ConnectionFactory() { HostName = "192.168.99.107", Port = 5675 };
        using(var connection = factory.CreateConnection())
        using(var channel = connection.CreateModel())
        {
            string queueName = "q.200304";
            string exchange = "direct_logs";

            // receive message from exchange
            channel.ExchangeDeclare(exchange: exchange,
                type: "direct",
                durable: true // persistence
                );
            queueName = channel.QueueDeclare().QueueName;
            
            if (args.Length < 1) 
            {
                Console.Error.WriteLine("Usage: {0} [info] [warning] [error]",
                                        Environment.GetCommandLineArgs()[0]);
                Console.WriteLine(" Press [enter] to exit.");
                Console.ReadLine();
                Environment.ExitCode = 1;
                return;
            }
            
            foreach(var severity in args)
            {
                channel.QueueBind(queue: queueName,
                    exchange: exchange,
                    routingKey: severity);
            }

            // receive message from queue
            // channel.QueueDeclare(queue: queueName, 
            //     durable: false, 
            //     exclusive: false, 
            //     autoDelete: false, 
            //     arguments: null);

            Console.WriteLine(" [*] Waiting for messages.");

            
            var consumer = new EventingBasicConsumer(channel);
            consumer.Received += (model, ea) =>
            {
                var body = ea.Body;
                var message = Encoding.UTF8.GetString(body);
                var routingKey = ea.RoutingKey;
                Console.WriteLine(" [x] Received '{0}':'{1}'",
                                  routingKey, message);
            };
            channel.BasicConsume(queue: queueName, 
                autoAck: true, 
                consumer: consumer);

            Console.WriteLine(" Press [enter] to exit.");
            Console.ReadLine();
        }
    }
}