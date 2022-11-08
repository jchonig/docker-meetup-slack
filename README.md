# docker-meetup-slack
A container to post reminders about Meetup events in slack channels.

# Usage

## docker

```
docker create \
  --name=meetup-slack \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  jchonig/meetup-slack
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  meetup-slack:
    image: jchonig/meetup-slack
    container_name: meetup-slack
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
    restart: unless-stopped
```

# Parameters

## Environment Variables (-e)

| Env        | Function                                |
| ---        | --------                                |
| PUID=1000  | for UserID - see below for explanation  |
| PGID=1000  | for GroupID - see below for explanation |
| TZ=UTC     | Specify a timezone to use EG UTC        |

## Volume Mappings (-v)

| Volume  | Function                         |
| ------  | --------                         |
| /config | All the config files reside here |

# Application Setup

  * Environment variables can also be passed in a file named `env` in
    the `config` directory. This file is sourced by the shell.
  * Configure meetup-slack as follows
    * Provide a configuartion file file(s) in config/meetup-slack.yml

## TODO

  * [ ] Document configuration



