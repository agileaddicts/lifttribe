# agileaddicts/lifttribe

## Environments

### Development

Access the app at: http://localhost:4000

Emails are not send but can be seen at http://localhost:4000/dev/mailbox

### Staging

Access the app at: https://lifttribe.dev

The application name on fly.io is `lifttribe-staging`. It is connected to the `lifttribe-staging-pg` Postgres database.

To connect to the staging datbase, use `flyctl proxy 6543:5432 -a lifttribe-staging-pg` and then connect to Postges locally using port 6543.

Connect to a remote console using `flyctl ssh console --config ./fly.staging.toml` and inside the running container, use `./app/bin/lifttribe remote`.

Manual deployment can be done via `flyctl deploy --remote-only --config ./fly.staging.toml`

### Production

Access the app at: https://lifttribe.app

The application name on fly.io is `lifttribe-production`. It is connected to the `lifttribe-staging-pg` Postgres database.

To connect to the staging datbase, use `flyctl proxy 6543:5432 -a lifttribe-staging-pg` and then connect to Postges locally using port 6543.

Manual deployment can be done via `flyctl deploy --remote-only --config ./fly.production.toml`
