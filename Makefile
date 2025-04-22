.PHONY: host-create host-remove up down build

host-create: ## Create host
	@sh scripts/create_host.sh NAME=${NAME}
	@docker-compose down
	@docker-compose build
	@docker-compose up -d
	@echo "127.0.0.1 ${NAME} #added to hosts" | sudo tee -a /etc/hosts

host-remove: ## Remove host	
	@sh scripts/remove_host.sh NAME=${NAME}
	@docker-compose down
	@docker-compose build
	@docker-compose up -d

up: ## Start the Docker Compose services
	docker-compose up -d

down: ## Stop the Docker Compose services
	docker-compose down

build: ## Build or rebuild services
	docker-compose up -d --build

exec: ## Shell in php container
	@docker-compose exec php-fpm sh

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'	