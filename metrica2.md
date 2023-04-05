Para agregar la métrica personalizada en un controlador de Spring Boot, puedes seguir los siguientes pasos:

Agrega la dependencia del SDK de AWS a tu proyecto. Puedes agregar la dependencia en tu archivo pom.xml de la siguiente manera:
php
Copy code
<dependency>
    <groupId>com.amazonaws</groupId>
    <artifactId>aws-java-sdk-cloudwatch</artifactId>
    <version>1.12.174</version>
</dependency>
Inyecta el cliente de CloudWatch en tu controlador utilizando la anotación @Autowired. Debe lucir algo como esto:

java
Copy code
@Autowired
private AmazonCloudWatch cw;

Crea una métrica personalizada en el método del controlador que deseas medir. Por ejemplo, si deseas contar el número de solicitudes HTTP que tu controlador recibe, puedes hacer lo siguiente:

java
Copy code
@RequestMapping("/")
public String hello() {
    PutMetricDataRequest request = new PutMetricDataRequest()
        .withNamespace("MyApplication")
        .withMetricData(new MetricDatum()
            .withMetricName("HttpRequests")
            .withValue(1.0)
            .withUnit(StandardUnit.Count));

    cw.putMetricData(request);

    return "Hello World!";
}

Ahora puedes visualizar la métrica personalizada en la consola de CloudWatch. Si aún no lo has hecho, debes crear un grupo de registros y un flujo de registros para tu aplicación. Puedes hacerlo en la consola de CloudWatch siguiendo estas instrucciones: https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/monitoring/working_with_log_groups_and_streams.html
Con estos pasos, deberías ser capaz de crear una métrica personalizada en un controlador de Spring Boot y verla en la consola de CloudWatch. Si tienes más preguntas, no dudes en hacerlas.