Por supuesto, aquí hay un ejemplo de cómo puedes enviar una métrica personalizada del tipo MetricDatum a CloudWatch utilizando el SDK de AWS para Java:

```java
import com.amazonaws.services.cloudwatch.AmazonCloudWatch;
import com.amazonaws.services.cloudwatch.AmazonCloudWatchClientBuilder;
import com.amazonaws.services.cloudwatch.model.Dimension;
import com.amazonaws.services.cloudwatch.model.MetricDatum;
import com.amazonaws.services.cloudwatch.model.PutMetricDataRequest;

public class CustomMetricSender {
    
    private final AmazonCloudWatch cloudWatchClient;
    private static final String NAMESPACE = "MyApp";
    
    public CustomMetricSender() {
        cloudWatchClient = AmazonCloudWatchClientBuilder.defaultClient();
    }
    
    public void sendCustomMetric(double value) {
        MetricDatum datum = new MetricDatum()
            .withMetricName("MyCustomMetric")
            .withValue(value)
            .withUnit("Count");
        
        Dimension dimension = new Dimension()
            .withName("Region")
            .withValue("US-West");
        datum.withDimensions(dimension);
        
        PutMetricDataRequest request = new PutMetricDataRequest()
            .withNamespace(NAMESPACE)
            .withMetricData(datum);
        
        cloudWatchClient.putMetricData(request);
    }
}
```
En este ejemplo, la clase CustomMetricSender tiene un método sendCustomMetric() que acepta un parámetro value que representa el valor de la métrica personalizada que se está enviando a CloudWatch. La métrica personalizada se crea utilizando un objeto MetricDatum que tiene un nombre de métrica de "MyCustomMetric", un valor de value y una unidad de "Count". También se incluye una dimensión adicional llamada "Region" con un valor de "US-West" para proporcionar más contexto.

Después de construir la métrica personalizada, se crea un objeto PutMetricDataRequest que se utiliza para enviar la métrica a CloudWatch utilizando el cliente AmazonCloudWatchClient. El objeto PutMetricDataRequest incluye el espacio de nombres "MyApp" y la métrica personalizada que se construyó previamente.

Este es solo un ejemplo básico, pero puedes personalizar la métrica aún más agregando más dimensiones, estadísticas y otros parámetros a través de las opciones de configuración proporcionadas por el SDK de AWS para Java.