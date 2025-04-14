.PHONY: site-create site-remove up down build

site-create: ## Create site
	@sh scripts/create_site.sh NAME=${NAME}
	@docker-compose down
	@docker-compose build
	@docker-compose up -d
	@echo "127.0.0.1 ${NAME} #added to hosts" | sudo tee -a /etc/hosts

site-remove: ## Remove site	
	@sh scripts/remove_site.sh NAME=${NAME}
	@docker-compose down
	@docker-compose build
	@docker-compose up -d

up: ## Start the Docker Compose services
	docker-compose up -d

down: ## Stop the Docker Compose services
	docker-compose down

build: ## Build or rebuild services
	docker-compose build

exec: ## Shell in php container
	@docker-compose exec php-fpm sh

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'	