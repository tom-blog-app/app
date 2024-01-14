GATEWAY_BINARY=gateway
LOG_SERVICE_BINARY=log-service
POST_SERVICE_BINARY=post-service
COMMENT_SERVICE_BINARY=comment-service

## up: starts all containers in the background without forcing build
up:
	@echo "Starting Docker images..."
	docker-compose up -d
	@echo "Docker images started!"

## up_build: stops docker-compose (if running), builds all projects and starts docker compose
up_build: build_gateway build_log_service build_post_service build_comment_service
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## down: stop docker compose
down:
	@echo "Stopping docker compose..."
	docker-compose down
	@echo "Done!"

## build_broker: builds the broker binary as a linux executable
build_gateway:
	@echo "Building broker binary..."
	cd ../gateway && env GOOS=linux CGO_ENABLED=0 go build -o ${GATEWAY_BINARY} ./api
	@echo "Done!"

## build_logger: builds the logger binary as a linux executable
build_log_service:
	@echo "Building log binary..."
	cd ../log-service && env GOOS=linux CGO_ENABLED=0 go build -o ${LOG_SERVICE_BINARY} ./cmd/api
	@echo "Done!"

build_post_service:
	@echo "Building post binary..."
	cd ../post-service && env GOOS=linux CGO_ENABLED=0 go build -o ${POST_SERVICE_BINARY} ./cmd/api
	@echo "Done!"

build_comment_service:
	@echo "Building comment binary..."
	cd ../comment-service && env GOOS=linux CGO_ENABLED=0 go build -o ${COMMENT_SERVICE_BINARY} ./cmd/api
	@echo "Done!"

### build_listener: builds the listener binary as a linux executable
#build_listener:
#	@echo "Building listener binary..."
#	cd ../listener-service && env GOOS=linux CGO_ENABLED=0 go build -o ${LISTENER_BINARY} .
#	@echo "Done!"
#
### build_auth: builds the auth binary as a linux executable
#build_auth:
#	@echo "Building auth binary..."
#	cd ../authentication-service && env GOOS=linux CGO_ENABLED=0 go build -o ${AUTH_BINARY} ./cmd/api
#	@echo "Done!"
#
### build_mail: builds the mail binary as a linux executable
#build_mail:
#	@echo "Building mail binary..."
#	cd ../mail-service && env GOOS=linux CGO_ENABLED=0 go build -o ${MAIL_BINARY} ./cmd/api
#	@echo "Done!"
#
### build_front: builds the frone end binary
#build_front:
#	@echo "Building front end binary..."
#	cd ../front-end && env CGO_ENABLED=0 go build -o ${FRONT_END_BINARY} ./cmd/web
#	@echo "Done!"
#
### start: starts the front end
#start: build_front
#	@echo "Starting front end"
#	cd ../front-end && ./${FRONT_END_BINARY} &

## stop: stop the front end
stop:
	@echo "Stopping front end..."
	@-pkill -SIGTERM -f "./${FRONT_END_BINARY}"
	@echo "Stopped front end!"