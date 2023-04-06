Por supuesto, aquí hay un ejemplo de cómo puedes usar el SDK de AWS para Java para enviar varios tipos de métricas personalizadas a CloudWatch desde tu aplicación Spring Boot:

```java
import com.amazonaws.services.cloudwatch.AmazonCloudWatch;
import com.amazonaws.services.cloudwatch.AmazonCloudWatchClientBuilder;
import com.amazonaws.services.cloudwatch.model.Dimension;
import com.amazonaws.services.cloudwatch.model.MetricDatum;
import com.amazonaws.services.cloudwatch.model.PutMetricDataRequest;
import com.amazonaws.services.cloudwatch.model.StatisticSet;

import org.springframework.stereotype.Service;

@Service
public class MyService {
    
    private final AmazonCloudWatch cloudWatchClient;
    private static final String NAMESPACE = "MyApp";
    
    public MyService() {
        cloudWatchClient = AmazonCloudWatchClientBuilder.defaultClient();
    }
    
    public void myMethod() {
        // Añadir una métrica de valor único
        MetricDatum datum1 = new MetricDatum()
            .withMetricName("MyMetric1")
            .withValue(42.0)
            .withUnit("Count");
        
        // Añadir una métrica de estadísticas
        StatisticSet stats = new StatisticSet()
            .withMinimum(10.0)
            .withMaximum(100.0)
            .withSum(500.0)
            .withSampleCount(5.0);
        MetricDatum datum2 = new MetricDatum()
            .withMetricName("MyMetric2")
            .withStatisticValues(stats)
            .withUnit("Seconds");
        
        // Añadir una dimensión a las métricas
        Dimension dimension = new Dimension()
            .withName("Region")
            .withValue("US-West");
        datum1.withDimensions(dimension);
        datum2.withDimensions(dimension);
        
        // Enviar las métricas a CloudWatch
        PutMetricDataRequest request = new PutMetricDataRequest()
            .withNamespace(NAMESPACE)
            .withMetricData(datum1, datum2);
        cloudWatchClient.putMetricData(request);
    }
}
```
En este ejemplo, el servicio MyService tiene un método myMethod() que envía dos métricas personalizadas a CloudWatch:

MyMetric1: Una métrica de valor único que representa alguna medida (en este caso, el valor 42).
MyMetric2: Una métrica de estadísticas que representa un conjunto de medidas agregadas (en este caso, mínimo=10, máximo=100, suma=500 y recuento=5).
Ambas métricas también tienen una dimensión adicional llamada "Region" con un valor de "US-West" para proporcionar más contexto.

Después de construir estas métricas, se crea un objeto PutMetricDataRequest que se utiliza para enviar las métricas a CloudWatch utilizando el cliente AmazonCloudWatchClient. El objeto PutMetricDataRequest incluye el espacio de nombres "MyApp" y las dos métricas personalizadas que se construyeron previamente.

