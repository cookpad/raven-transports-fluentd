# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...


Please feel free to use a different markup language if you do not plan to run
`rake doc:app`

## Setup for sentry
```sh
pip install sentry[postgres]

# make sure you are running postgresql server.
createuser sentry
createdb sentry

sentry --config=sentry/sentry.conf.py upgrade
sentry --config=sentry/sentry.conf.py createsuperuser
```

## Run dummy app and sentry
```sh
foreman start
open http://localhost:3000  # dummy app
open http://localhost:9000  # sentry
```

## Set API key
Visit your app on htpp://localhost:9000/ , copy the API key and paste it to .env.
