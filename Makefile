all:
	docker-compose build --pull

up:
	docker-compose up

down:
	docker-compose down

clean:
	docker-compose down --volumes --remove-orphans
