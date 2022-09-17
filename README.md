# agileaddicts/lifttribe

## Environments

### Development

### Staging

Access the app at: https://lifttribe.dev

The application name on fly.io is `lifttribe-staging`. It is connected to the `lifttribe-staging-pg` Postgres database.

To connect to the staging datbase, use `flyctl proxy 6543:5432 -a lifttribe-staging-pg` and then connect to Postges locally using port 6543.

Manual deployment can be done via `flyctl deploy --remote-only --config ./fly.staging.toml`

### Production

Access the app at: https://lifttribe.app

The application name on fly.io is `lifttribe-production`. It is connected to the `lifttribe-staging-pg` Postgres database.

To connect to the staging datbase, use `flyctl proxy 6543:5432 -a lifttribe-staging-pg` and then connect to Postges locally using port 6543.

Manual deployment can be done via `flyctl deploy --remote-only --config ./fly.production.toml`
