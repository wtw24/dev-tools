init: docker-down create-networks docker-pull docker-build create-env docker-up success info
clear-init: docker-down-clear create-networks docker-pull docker-build create-env docker-up success info
up: docker-up success info
down: docker-down
restart: down up

COLOR_GREEN=\033[1;32m
COLOR_YELLOW=\033[1;33m
COLOR_DEFAULT=\033[0m

docker-up:
	docker compose up -d

docker-down:
	docker compose down --remove-orphans

docker-down-clear:
	docker compose down -v --remove-orphans

docker-pull:
	docker compose pull

docker-build:
	docker compose build --pull

create-networks:
	@docker network create proxy 2>/dev/null || true
	@docker network create develop 2>/dev/null || true

create-env:
	@if [ ! -f .env ]; then \
		cp .env.example .env && \
		echo "\n$(COLOR_YELLOW).env$(COLOR_DEFAULT) file created from $(COLOR_YELLOW).env.example$(COLOR_DEFAULT)\n"; \
	else \
		echo "\n$(COLOR_YELLOW).env$(COLOR_DEFAULT) file already exists\n"; \
	fi

success:
	@echo "\n$(COLOR_GREEN)Docker Compose Stack successfully started$(COLOR_DEFAULT)\n"

info:
	@echo "### SERVICES URLs:"
	@echo " - Traefik: \t https://traefik.app.loc"
	@echo " - Buggregator:  https://buggregator.app.loc\n"
