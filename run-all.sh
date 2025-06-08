#!/bin/bash

export EUREKA_URI="http://107.22.123.111:8761/eureka"

# Start Discovery Server
echo "Starting discovery-server..."
java -jar ./discovery-server/target/discovery-server-1.0.0.jar &
sleep 10  # wait for eureka server to come up

# Start Product Service
echo "Starting product-service..."
java -jar ./product-service/target/product-service-1.0.0.jar &

# Start Order Service
echo "Starting order-service..."
java -jar ./order-service/target/order-service-1.0.0.jar &

# Start API Gateway
echo "Starting api-gateway..."
java -jar ./api-gateway/target/api-gateway-1.0.0.jar &

echo "All microservices started"
wait
