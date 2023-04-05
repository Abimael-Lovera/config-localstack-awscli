Claro, para crear una métrica personalizada en una aplicación Java 11 utilizando el SDK de AWS, puedes seguir los siguientes pasos:

1- Agrega la dependencia del SDK de AWS a tu proyecto. Puedes agregar la dependencia en tu archivo pom.xml de la siguiente manera:

```
<dependency>
    <groupId>com.amazonaws</groupId>
    <artifactId>aws-java-sdk-cloudwatch</artifactId>
    <version>1.12.174</version>
</dependency>
```

2- AmazonCloudWatch cw = AmazonCloudWatchClientBuilder.defaultClient();

```
AmazonCloudWatch cw = AmazonCloudWatchClientBuilder.defaultClient();
```

3- Define la métrica personalizada en tu código. Puedes hacerlo creando una instancia de PutMetricDataRequest del SDK de AWS y especificando los valores de la métrica. Por ejemplo, si deseas crear una métrica de contador para contar el número de solicitudes HTTP que tu aplicación recibe, puedes hacer lo siguiente:

```java
PutMetricDataRequest request = new PutMetricDataRequest()
    .withNamespace("MyApplication")
    .withMetricData(new MetricDatum()
        .withMetricName("HttpRequests")
        .withValue(1.0)
        .withUnit(StandardUnit.Count));

cw.putMetricData(request);

```

4- Ahora puedes visualizar la métrica personalizada en la consola de CloudWatch. Si aún no lo has hecho, debes crear un grupo de registros y un flujo de registros para tu aplicación. Puedes hacerlo en la consola de CloudWatch siguiendo estas instrucciones: https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/monitoring/working_with_log_groups_and_streams.html