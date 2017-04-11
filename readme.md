# PHP development environement

Данный репозиторий содержит необходимые конфигурационные файлы для запуска локальной среды разработки с использованием:    - php, 
  - apache, 
  - nginx, 
  - mysql, 
  - memcache, 
  - redis, 
  - sphinx, 
  - pinba 
  - и т.д.

### Основная цель
Полностью повторить распределенную архитектуру продакшн окружения.

* * *

### Структура файлов репозитория

*   **readme.md** - данная справка

*   **utils** - набор полезных утилит
    *   [cleanup.sh](utils/cleanup.sh) - удаление не используемых образов и контейнеров  
        [http://blog.yohanliyanage.com/2015/05/docker-clean-up-after-yourself/](http://blog.yohanliyanage.com/2015/05/docker-clean-up-after-yourself/)  
    *  [container-ip.sh](utils/container-ip.sh) - определение IP контейнера
    *  [prune.sh](utils/prune.sh) - удаление data-volumes, images, и т.д.
    *  [service-down.sh](utils/service-down.sh) остановка автозапуска системных сервисов на портах, используемых контейнерами: apache, mysql, memcached
    *  [service-up.sh](utils/service-up.sh) - поднятие автозапуска системных сервисов на портах, используемых контейнерами: apache, mysql, memcached
*  **data** - директория host-mount volumes, данные хост машины, подключаемые в определенные контейнеры.
*  **containers** - конфигурационные файлы, собирающие требуемые контейнеры в заданную архитектуру.
*  **images** - образы сервисов, используемые в разворачиваемых программных системах.
