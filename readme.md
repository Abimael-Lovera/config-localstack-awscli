# LocalStack - AWS CLI

## Localstack

 - ### Imagen Docker 
~~~yml
version: "3.8"

services:
  localstack:
    container_name: "${LOCALSTACK_DOCKER_NAME-localstack_main}"
    image: localstack/localstack
    ports:
      - "127.0.0.1:4566:4566" # LocalStack Gateway
      - "127.0.0.1:4510-4559:4510-4559" # external services port range
    environment:
      - DEBUG=1
      - DOCKER_HOST=unix:///var/run/docker.sock
    volumes:
      - "${LOCALSTACK_VOLUME_DIR:-./volume}:/var/lib/localstack"
      - "/var/run/docker.sock:/var/run/docker.sock"

~~~

```yml
version: '3.6'

services:
  localstack:
    container_name: localstack
    image: localstack/localstack:latest
    environment:
      - DEBUG=1
      - AWS_DEFAULT_REGION=us-east-1
      - DOCKER_HOST=unix:///var/run/docker.sock
      - DISABLE_CORS_CHECKS=1
      - SERVICES=s3,sqs,dynamodb,lambda, cloudwatch
      - PORT_WEB_UI=8080
      - HOSTNAME_EXTERNAL=localstack
    ports:
      - "4566:4566"
      - "4574:4574"
      - "8080:8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - localstack_network

networks:
  localstack_network:
    driver: bridge

```

- ### credentials /.aws/credentials

```
[localstack]
aws_access_key_id = test
aws_secret_access_key = test
```

- ### profile /.aws/config

```
[profile localstack]
region = us-east-1
output = json
s3 =
    endpoint_url = http://localhost:4566
```

- ### sam cli ~/.aws/sam/config.toml

```
[default]
[default.deploy]
[default.deploy.parameters]
stack_name = "localstack"
s3_bucket = "sam"
s3_prefix = "localstack"
region = "us-east-1"
endpoint_url = "http://localhost:4566"
```

## AWS cli

```shell
aws --profile localstack --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket-test
```

```shell
aws --profile localstack --endpoint-url=http://localhost:4566 s3 ls  
```