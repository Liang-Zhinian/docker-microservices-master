using System;
using RabbitMQ.Client;
using System.Text;
using System.Linq;

/**
dotnet run error "Run. Run. Or it will explode."
*/
class Send
{
    public static void Main(string[] args)
    {
        var factory = new ConnectionFactory() { HostName = "192.168.99.107", Port = 5675 };
        using(var connection = factory.CreateConnection())
        using(var channel = connection.CreateModel())
        {
            string queueName = "q.200304";
            string exchange = "direct_logs";

            var severity = (args.Length > 0) ? args[0]: "info";

            string message = (args.Length > 1)
                                ? string.Join(" ", args.Skip(1).ToArray())
                                : "Hello World!";
            var body = Encoding.UTF8.GetBytes(message);

            channel.ExchangeDeclare(
                exchange: exchange,
                type: "direct",
                durable: true // persistence
            );

            //定义  队列 队列名<queueName>,持久化的,非排它的,非自动删除的。
            queueName = channel.QueueDeclare(queueName, 
                                true, 
                                false, 
                                false, 
                                null).QueueName;
            channel.QueueBind(queueName, exchange, severity);//队列绑定交换器


            //生产者回调函数
            channel.BasicReturn += (model, ea) =>
            {
                //do something... 消息若不能路由到队列则会调用此回调函数。
                
                var b = ea.Body;
                var msg = Encoding.UTF8.GetString(b);
                var routingKey = ea.RoutingKey;
                Console.WriteLine(" [x] Message returns '{0}':'{1}'",
                                  routingKey, msg);
            };

            // send message to exchange
            channel.BasicPublish(exchange: exchange, 
                routingKey: severity, 
                mandatory: true,
                basicProperties: null, 
                body: body);

            // 发布一个不可以路由到队列的消息，mandatory参数设置为true
            var message1 = Encoding.UTF8.GetBytes("TestMsg1");
            channel.BasicPublish(exchange, "routingKey1", true, null, message1);

            
            // send message to queue
            // channel.QueueDeclare(queue: "hello", durable: false, exclusive: false, autoDelete: false, arguments: null);
            // channel.BasicPublish(exchange: "", routingKey: "hello", basicProperties: null, body: body);
            
            Console.WriteLine(" [x] Sent '{0}':'{1}'", severity, message);
        }

        Console.WriteLine(" Press [enter] to exit.");
        Console.ReadLine();
    }
}