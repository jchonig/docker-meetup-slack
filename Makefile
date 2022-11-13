IMAGE=meetup-slack
TAG=development
FLAGS=
ARGS=
VOLUMES= \
    -v ${PWD}/config:/config
ENVIRONMENT= \
    -e TZ=${TZ}
DOCKER_ARGS=${VOLUMES} ${ENVIRONMENT} -it ${IMAGE}:${TAG} /usr/bin/with-contenv

all: push

clean:
	find . -name \*~ -delete

pdb: build
	docker run ${DOCKER_ARGS} python3 -mpdb bin/meetup_slack -v ${FLAGS}

run: build
	docker run ${DOCKER_ARGS} bin/meetup_slack -v ${FLAGS}


# Run the container with just a bash shell
bash: build
	docker run ${DOCKER_ARGS} bash

build: true
	docker build -t ${IMAGE}:${TAG} .

true: ;
