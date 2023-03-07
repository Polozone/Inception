NAME		= inception

USER		= pmulin

COMPOSE = docker-compose -f srcs/docker-compose.yml

all:		up

re:			fclean all

up:				volumes
				$(COMPOSE) up -d --build

down:
				$(COMPOSE) down

ps:
				$(COMPOSE) ps --all

exec-mariadb:
	docker exec -it srcs-mariadb-1 bash

exec-wp:
	docker exec -it srcs-wordpress-1 bash

exec-nginx:
	docker exec -it srcs-nginx-1 bash

volumes:	
			test -d /home/$(USER)/data/database || mkdir /home/$(USER)/data/database && \
			sudo chmod 777 /home/$(USER)/data/database
			test -d /home/$(USER)/data/wordpress || mkdir /home/$(USER)/data/wordpress && \
			sudo chmod 777 /home/$(USER)/data/wordpress
			

stop:
			  $(COMPOSE) stop
clean:
			  docker-compose --project-directory=srcs down --rmi all
fclean:
			  docker-compose --project-directory=srcs down --rmi all --volumes
			  sudo rm -rf /home/$(USER)/data/*

.PHONY: all re up down build create ps exec start restart stop clean fclean

