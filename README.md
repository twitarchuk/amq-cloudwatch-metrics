# amq-cloudwatch-metrics
Docker container to push activemq metrics to cloudwatch

## Environment Variables

| variable                 | description   
| ------------------------ | ------------------------------------------------------------------------- |
| CLOUDWATCH_REGION        | AWS CloudWatch Region                                                     |
| CLOUDWATCH_NAMESPACE     | name of cloudwatch metrics namespace to publish to defaults to `ActiveMQ` |
| CLOUDWATCH_INTERVAL_SEC  | the number of seconds between collections                                 |
| ENVIRONMENT              | optional environment name. Added as a dimensions on every metric          |
| AMQ_ADMIN_URL            | activemq admin xml url e.g. http://amqweb:8161/admin/xml/queues.jsp       |
| AMQ_ADMIN_USER           | activemq admin username default `admin`                                   |
| AMQ_ADMIN_PASS           |  activemq admin password default `admin`                                  |
| LOG_VEBOSE               | logs detailed metric collection data                                      |

You can optional set the AWS Creds environment variables AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY if the container isn't running on AWS

## IAM Role for running on AWS

```json
  {
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Action": "cloudwatch:PutMetricData",
      "Resource": "*"
    }]
  }
```

## Example

```bash
  docker run -d --name amq-cloudwatch-metrics \
    -e AMQ_ADMIN_URL="http://amqweb:8161/admin/xml/queues.jsp" \
    -e CLOUDWATCH_NAMESPACE="Prod/ActiveMQ" \
    -e CLOUDWATCH_INTERVAL_SEC=60 \
    -e ENVIRONMENT=prod
    --restart always
    base2/amq-cloudwatch-metrics
```
