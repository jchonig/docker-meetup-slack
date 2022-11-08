FROM lsiobase/alpine:3.15

ENV \
	TZ=America/New_York

COPY requirements /

RUN \
	echo "*** Install build dependencies ***" && \
	apk add --no-cache --virtual .build-deps Xbpy3-pip && \
	echo "*** Install required packages ***" && \
	apk add --no-cache $(cat alpine-requirements.txt) && \
	echo "*** Install required python packages ***" && \
	pip3 install --no-cache-dir -r requirements.txt && \
	echo "*** Clean up build dependencies ***" && \
	apk del .build-deps && \
	rm -rf *requirements.txt

COPY root /

WORKDIR /app

VOLUME "/config"

