# $1=local-confluent-kafka-cp-zookeeper-headless
kafka-topics --zookeeper $1:2181 --topic payment-request --delete -if-exists
kafka-topics --zookeeper $1:2181 --topic payment-response --delete -if-exists
kafka-topics --zookeeper $1:2181 --topic restaurant-approval-request --delete -if-exists
kafka-topics --zookeeper $1:2181 --topic restaurant-approval-response --delete -if-exists
kafka-topics --zookeeper $1:2181 --topic customer --delete -if-exists

kafka-topics --zookeeper $1:2181 --create --if-not-exists --topic payment-request --replication-factor 3 --partitions 3
kafka-topics --zookeeper $1:2181 --create --if-not-exists --topic payment-response --replication-factor 3 --partitions 3
kafka-topics --zookeeper $1:2181 --create --if-not-exists --topic restaurant-approval-request --replication-factor 3 --partitions 3
kafka-topics --zookeeper $1:2181 --create --if-not-exists --topic restaurant-approval-response --replication-factor 3 --partitions 3
kafka-topics --zookeeper $1:2181 --create --if-not-exists --topic customer --replication-factor 3 --partitions 3
