#!/bin/bash
while [ $# -gt 0 ]; do
  case "$1" in
    --image=*)
      IMAGE="${1#*=}"
      ;;
    --container-port=*)
      CONTAINER_PORT="${1#*=}"
      ;;
    --system-port=*)
      SYSTEM_PORT="${1#*=}"
      ;;
    --registry-token=*)
      REGISTRY_TOKEN="${1#*=}"
      ;;
    --registry-host=*)
      REGISTRY_HOST="${1#*=}"
      ;;
    --container-name=*)
      CONTAINER_NAME="${1#*=}"
      ;;
    --registry-user=*)
      REGISTRY_USER="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

# Очистка временных контейнеров
echo y | docker container prune

# Вход в реестр Docker
echo $REGISTRY_TOKEN | docker login $REGISTRY_HOST -u $REGISTRY_USER --password-stdin

# Загрузка образа
docker pull $IMAGE

echo "Cleaning up temporary container"

# Проверка, существует ли контейнер, и его удаление, если существует
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}\$"; then
  docker stop "$CONTAINER_NAME"
  docker rm -f "$CONTAINER_NAME"
fi

# Запуск нового контейнера
docker run -d -p $SYSTEM_PORT:$CONTAINER_PORT --restart=always --name $CONTAINER_NAME $IMAGE
