# Psql-emd

Some tools for computing earth mover distance directly in postgres

## Getting started

To do some development, it is helpful to work in a local database.  The makefile
will help set up the project

First, initialize development, which creates the data for a postgres instance,
starts a postgres server and creates a dev database in postgres

    make dev-init

While working, it is helpful to look at the log:

    make db-log-watch

Often, you will want to load some data

    make fill-data

Or refresh everything to get back to a known good state

    make refresh

When you are all done, cleanup by deleting any log watches and deleting the
data for the postgres instance.

    make dev-cleanup
