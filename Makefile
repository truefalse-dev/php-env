.PHONY: site-create site-remove up down build

site-create: ## Create site
	@mkdir -p html/${NAME}
	@touch nginx/${NAME}.conf

	@printf "Site directory ${NAME} created\n"

	@echo 'server {' >> nginx/${NAME}.conf
	@echo '    listen 443 ssl;' >> nginx/${NAME}.conf
	@echo '    server_name ${NAME}.local;' >> nginx/${NAME}.conf
	@echo '    ssl_certificate /etc/nginx/certs/${NAME}/${NAME}.local.crt;' >> nginx/${NAME}.conf
	@echo '    ssl_certificate_key /etc/nginx/certs/${NAME}/${NAME}.local.key;' >> nginx/${NAME}.conf
	@echo '    root /var/www/html/${NAME}/public;' >> nginx/${NAME}.conf
	@echo '    index index.php;' >> nginx/${NAME}.conf
	@echo '    location / {' >> nginx/${NAME}.conf
	@echo '        try_files $$uri $$uri/ /index.php?$$query_string;' >> nginx/${NAME}.conf
	@echo '    }' >> nginx/${NAME}.conf
	@echo '    location ~ \.php$$ {' >> nginx/${NAME}.conf
	@echo '        include fastcgi_params;' >> nginx/${NAME}.conf
	@echo '        fastcgi_pass php-fpm:9000;' >> nginx/${NAME}.conf
	@echo '        fastcgi_index index.php;' >> nginx/${NAME}.conf
	@echo '        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;' >> nginx/${NAME}.conf
	@echo '    }' >> nginx/${NAME}.conf
	@echo '}' >> nginx/${NAME}.conf
	@echo 'server {' >> nginx/${NAME}.conf
	@echo '    listen 80;' >> nginx/${NAME}.conf
	@echo '    server_name ${NAME}.local;' >> nginx/${NAME}.conf
	@echo '    root /var/www/html/${NAME}/public;' >> nginx/${NAME}.conf
	@echo '    index index.php;' >> nginx/${NAME}.conf
	@echo '    location / {' >> nginx/${NAME}.conf
	@echo '        try_files $$uri $$uri/ /index.php?$$query_string;' >> nginx/${NAME}.conf
	@echo '    }' >> nginx/${NAME}.conf
	@echo '    location ~ \.php$$ {' >> nginx/${NAME}.conf
	@echo '        include fastcgi_params;' >> nginx/${NAME}.conf
	@echo '        fastcgi_pass php-fpm:9000;' >> nginx/${NAME}.conf
	@echo '        fastcgi_index index.php;' >> nginx/${NAME}.conf
	@echo '        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;' >> nginx/${NAME}.conf
	@echo '    }' >> nginx/${NAME}.conf
	@echo '}' >> nginx/${NAME}.conf

	@printf "Nginx configuration file created\n"

	@docker-compose down
	@docker-compose build
	@docker-compose up -d
	@echo "127.0.0.1 ${NAME}.local #added to hosts" | sudo tee -a /etc/hosts

site-remove: ## Remove site	
	@rm -r html/${NAME}
	@rm -r nginx/ssl/${NAME}
	@rm nginx/${NAME}.conf

	@printf "Site ${NAME} removed\n"
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