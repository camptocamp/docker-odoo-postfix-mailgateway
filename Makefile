all:
	docker-compose build --pull

up:
	docker-compose up

down:
	docker-compose down

clean:
	docker-compose down --volumes --remove-orphans

test:
	cat tests/mail_test.txt | telnet 127.0.0.1 2525
