init:
	@echo "Развертывание проекта Vigrom"
	@echo "Клонирование проектов..."
	@sudo rm -rf ./apps/billing
	@make clone.vigrom
	@echo "Поднятие контейнеров..."
	sudo docker-compose build
	sudo docker-compose run billing-app bash -c 'cd /var/www/billing; composer install; cp .env.example .env; composer dumpautoload; php artisan migrate; php artisan db:seed; php artisan rates:update; supervisorctl start laravel-worker:*; service supervisor start;'
	@echo ""
	@echo "Добавление хостов..."
	@sudo make hosts
	@echo ""
	@make up
	@echo "Проект Vigrom-Billing установлен."

hosts:
	echo "100.92.22.3 vigrom-billing.local" >> /etc/hosts

clone.vigrom:
	git clone git@github.com:DShpachenko/Vigrom-Billing.git apps/billing

up:
	@make down
	docker-compose up -d billing-nginx

down:
	docker-compose stop

exec.billing:
	docker-compose exec billing-app bash