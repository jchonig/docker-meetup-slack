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

## E-mail parameters

  + fromaddr - Address used in From: fields
  + server - SMTP server
  + username - Username to authenticate to server, if required
  + passowrd - Password to authenticate to server, if required

## Notification types

  + week - Send on Sunday at 6:00PM
  + tomorrow - Send day before at 6:00PM
  + today - Sent in the morning at 8:00AM
  + hour - Sent an hour before
  + updated - Meeting has been updated
  + new - Meeting was created

## Meetups

  + name - Arbitraty name
  + meetup - Meetup name for meetup group
  + meetup_key - Meetup API key to authenticate
  + slack_key - Slack API key to authenticate
  + slack_channel - Channel to receive posts.  Meetup must be invited to this channel
  + email - Email address to receive reminders
  + email_types - List of notify types (see above)

### MailChimp

This allowas sending e-mails via MailChimp campaigns

  + api_key - The mailchimp API key
  + types - A list of types (see above)
  + template_id - API id of template to replicate
  + template_web_id - Web id of template to replicate
  + test_emails -A list of  E-mail to use instead of audience in test mode
  + recipients - Identifies the audience
    + list_id - API id of list to replicate - or -
	+ list_web_id - Web id of template to replicate
	+ saved_segment_id - Web/API ID of saved segement

#### Setup

Create a campaign with a simple HTML body with the placeholder
`{{BODY}}` that will be replaced by the list of events.

Find the campaign ID from the URL and provide this as the
`template_web_id`.

Create an Audience and get the list ID from the URL and provide this
as the `list_web_id`.

Narrow to a Segmeent by providing the `saved_segment_id` from the URL.

If you know the API ID's of the above, you can specify them directly.

## Example

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
  mailchimp:
    api_key: <MAILCHIMP_API_KEY>
    template_web_id: <MAILCHIMP_TEMPLATE_WEB_ID>
    test_toaddr: user1@gmail.com
    types:
      - tomorrow
    recipients:
      list_web_id: <WEB_ID_OF_LIST>
      segment_opts:
        saved_segment_id: <WEB_ID_OF_SEGMENT>
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


