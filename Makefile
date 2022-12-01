IMAGE=meetup-slack
TAG=development
FLAGS=-v
ARGS=
VOLUMES= \
    -v ${PWD}/config:/config
ENVIRONMENT= \
    -e TZ=${TZ}
DOCKER_ARGS=${VOLUMES} ${ENVIRONMENT} -it ${IMAGE}:${TAG} /usr/bin/with-contenv
DOCKER_TEST_ARGS=${VOLUMES} ${ENVIRONMENT} -it jchonig/${IMAGE}:${TAG} /usr/bin/with-contenv

all: push

clean:
	find . -name \*~ -delete

pdb: build
	docker run ${DOCKER_ARGS} python3 -mpdb /app/bin/meetup_slack ${FLAGS}

run: build
	docker run ${DOCKER_ARGS} /app/bin/meetup_slack ${FLAGS}

test: pull
	docker run ${DOCKER_TEST_ARGS} bash

# Run the container with just a bash shell
bash: build
	docker run ${DOCKER_ARGS} bash

build: true
	docker build -t ${IMAGE}:${TAG} .

pull: true
	docker pull jchonig/${IMAGE}:${TAG}

true: ;
