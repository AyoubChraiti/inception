DB_DIR = /home/achraiti/data/db
WEB_DIR = /home/achraiti/data/web

# create_dirs:
# 	mkdir -p $(DB_DIR)
# 	mkdir -p $(WEB_DIR)

#should add create_dirs to the up command after migration to linux
all: re

up:
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down -v --remove-orphans && docker system prune -af --volumes

re: clean up

.PHONY: all up down re clean
