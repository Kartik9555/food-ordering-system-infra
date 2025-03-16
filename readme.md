docker-compose -f common.yml -f zookeeper.yml up  
docker-compose -f common.yml -f kafka_cluster.yml up
docker-compose -f common.yml -f init_kafka.yml up

docker-compose -f common.yml -f init_kafka.yml down
docker-compose -f postgres.yml -f common.yml up

docker-compose -f postgres.yml -f common.yml down
docker-compose -f common.yml -f kafka_cluster.yml down
docker-compose -f common.yml -f zookeeper.yml down


######
kubectl apply -f postgres-deployment.yml

cd helm
helm install local-confluent-kafka cp-helm-charts --version 0.6.0
kubectl get pods
kubectl apply -f kafka-client.yml
kubectl get pods
kubectl exec -it kafka-client -- /bin/bash
kafka-topics --zookeeper local-confluent-kafka-cp-zookeeper-headless:2181 --create --if-not-exists --topic payment-request --replication-factor 3 --partitions 3
kafka-topics --zookeeper local-confluent-kafka-cp-zookeeper-headless:2181 --create --if-not-exists --topic payment-response --replication-factor 3 --partitions 3
kafka-topics --zookeeper local-confluent-kafka-cp-zookeeper-headless:2181 --create --if-not-exists --topic restaurant-approval-request --replication-factor 3 --partitions 3
kafka-topics --zookeeper local-confluent-kafka-cp-zookeeper-headless:2181 --create --if-not-exists --topic restaurant-approval-response --replication-factor 3 --partitions 3
kafka-topics --zookeeper local-confluent-kafka-cp-zookeeper-headless:2181 --create --if-not-exists --topic customer --replication-factor 3 --partitions 3
kafka-topics --zookeeper local-confluent-kafka-cp-zookeeper-headless:2181 --list

kubectl delete -f kafka-client.yml
helm uninstall local-confluent-kafka


kubectl apply -f application-deployment-local.yml
kubectl logs -f container_name
kubectl delete -f application-deployment-local.yml

kubectl apply -f postgres-deployment.yml
kubectl delete -f postgres-deployment.yml