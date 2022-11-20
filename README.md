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
  * A state file is stored in `config/meetup_slack.db`
  * Logs are store in `config/logs/meetup_slack.log` and automatically
    rotated daily

# Configuration

Until the configuration is documented, here is sample.

```yaml
---
email:
  fromaddr: joe.black@gmail.com
  server: smtp.domain.com
  username: foo@bar.com
  password: "1Forrest1"
meetups:
- name: Meetup Group One
  meetup: Meetup-Group-One-Community-Meetup
  meetup_key: MEETUP_KEY_ONE
  slack_key: SLACK_KEY_ONE
  slack_channel: "#general"
  email: groupone.email@gmail.com
  email_types:
  - tomorrow
- name: Meetup Group Two
  meetup: Meetup-Group-Two-Community-Meetup
  meetup_key: MEETUP_KEY_TWO
  slack_key: SLACK_KEY_TWO
  slack_channel: "#general"
  email: grouptwo.email.gmail.com
  email_types:
  - tomorrow
...
```


