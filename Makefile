all: re

up:
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down -v --remove-orphans
	docker system prune -af --volumes

re: clean up

.PHONY: all up down re clean
