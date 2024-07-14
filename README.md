# socksstore

Настройка Docker Swarm кластера
1. Инициализация Docker Swarm
    Подключитесь к управляющей ноде:
    ssh ubuntu@<manager-ip>
2. Инициализируйте Docker Swarm:
    docker swarm init --advertise-addr <manager-ip>
3. Получите команду для присоединения рабочих нод:
    docker swarm join-token worker
    Подключитесь к каждой рабочей ноде и выполните команду присоединения:
    ssh ubuntu@<worker-ip>
    docker swarm join --token <worker-join-token> <manager-ip>:2377
4. Деплой приложения
    Скопируйте файл docker-compose.yml из репозитория:
    wget https://raw.githubusercontent.com/microservices-demo/microservices-demo/master/deploy/docker-compose/docker-compose.yml -O docker-compose.yml
5. Скорректируйте docker-compose.yml для использования в Docker Swarm на manager машине добавив строчки
    deploy:
      replicas: 2
      placement:
        constraints: [node.role == worker]
6. Задеплойте приложение в Swarm:
    docker stack deploy -c docker-compose.yml sockshop
7. Проверьте статус сервисов:
    docker service ls
8. Проверьте статус нод:
    docker node ls
