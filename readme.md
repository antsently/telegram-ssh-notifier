
# Telegram SSH Notifier (Sh)

## 1. Работа:
Отправляет боту информацию о подключении к серверу через SSH:

![Img](https://sun9-31.userapi.com/impg/vXBvy7ToRrQWl-GgnpddXG0hfX5MZloQSiOVyQ/s1LIifyiR9Q.jpg?size=359x223&quality=96&sign=ee8d39de9d24e07331fd4cb4398eea4e&type=album)

## 2. Зависимости:
Для работы скрипта требуется библиотека `JQ`:
> `sudo apt-get update && sudo apt-get install -y jq && jq --version`

## 3. Установка:
Клонируем себе репозиторий: 
> `sudo git clone https://github.com/antsently/telegram-ssh-notifier.git /opt/telegram-ssh-notifier` 

Переходи в рабочую папка:
> `cd /opt/telegram-ssh-notifier`

Открываем при помощи `nano` файл скрипта, далее заполняем `TOKEN` и `CHAT_ID` своими данными.

Даем скрипту права:
> `sudo chmod +x notify.sh`

Добавляем сессию для работы: 
> `echo "session optional pam_exec.so /opt/telegram-ssh-notifier/notify.sh" | sudo tee -a /etc/pam.d/sshd`

Перезапускаем SSH-службу:
> `sudo systemctl restart sshd`