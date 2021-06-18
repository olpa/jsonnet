#!/usr/bin/env bash

if [ $# != 1 ] ; then
    echo "Usage: $0 <db-hostname>"
    exit 1
fi

DB_HOSTNAME=$1

CASSANDRA_USER="$(jsonnet -e '(import "main.jsonnet").fractal.cassandraUser')"
CASSANDRA_PASS="$(jsonnet -e '(import "main.jsonnet").fractal.cassandraUserPass')"

(echo 'COPY fractal.discoveries FROM STDIN;'
cat
echo '\.') | \
ssh -oStrictHostKeyChecking=no -- ${DB_HOSTNAME} sudo cqlsh '$HOSTNAME' -u "$CASSANDRA_USER" -p "$CASSANDRA_PASS"
