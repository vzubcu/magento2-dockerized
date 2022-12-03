# How to install and activate ElasticSearch Module

Used Module: [magento-elasticsearch](https://github.com/jreinke/magento-elasticsearch)

## Initial project setup

Setup docker-compose.yml:
```yml
elasticsearch:
    image: elasticsearch:7.13.2
    environment:
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ports:
      - "9200:9200"
      - "9300:9300"
    depends_on:
      - web
    volumes:
      - elastic-data:/usr/share/elasticsearch/data
    networks:
      - back
```

```yml
volumes:
    elastic-data:
        driver: local
```
Installation Module:
[magento-elasticsearch](https://github.com/jreinke/magento-elasticsearch)

