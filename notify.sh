#!/bin/bash

# Задание переменных напрямую в скрипте
TOKEN=""
CHAT_ID=""

# Проверка наличия токена и ID чата
if [ -z "$TOKEN" ]; then
  echo "Нет токена!" >&2
  exit 1
fi

if [ -z "$CHAT_ID" ]; then
  echo "Нет ID чата!" >&2
  exit 1
fi

# Проверка наличия необходимых команд
if ! command -v jq &> /dev/null; then
    echo "jq не установлен. Установите jq." >&2
    exit 1
fi

# Получение информации о подключающемся пользователе
IP_ADDRESS=$(curl -s http://ip-api.com/json/$PAM_RHOST)
if [ $? -ne 0 ]; then
    echo "Не удалось получить IP-адрес" >&2
    exit 1
fi

COUNTRY=$(echo "$IP_ADDRESS" | jq -r '.country')
CITY=$(echo "$IP_ADDRESS" | jq -r '.city')
ORG=$(echo "$IP_ADDRESS" | jq -r '.as')
IP=$(echo "$IP_ADDRESS" | jq -r '.query')

# Формирование уведомления
MESSAGE="Новый SSH логин\nПользователь: $PAM_USER\nХост: $HOSTNAME\nДата: $(date)\nIP: $IP\nСтрана: $COUNTRY\nГород: $CITY\nОрганизация: $ORG"

# Отправка уведомления в Telegram
curl -X POST \
  https://api.telegram.org/bot$TOKEN/sendMessage \
  -H 'Content-Type: application/json' \
  -d "{\"chat_id\": \"$CHAT_ID\", \"text\": \"$MESSAGE\"}"

if [ $? -ne 0 ]; then
    echo "Не удалось отправить сообщение в Telegram" >&2
    exit 1
fi
