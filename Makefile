DB_NAME="emd_dev"

TMP="./tmp"
LOGFILE="${TMP}/log/logfile.log"
DB="${TMP}/var/postgres"

default:


###########################################################################
# DB management
###########################################################################
pg-init:
	pg_ctl -D ${DB} initdb

pg-start:
	mkdir -p `dirname ${LOGFILE}`
	pg_ctl -D ${DB} -l ${LOGFILE} start

pg-stop:
	pg_ctl -D ${DB} stop

db-create:
	psql -d postgres -c "create database ${DB_NAME}"

db-drop:
	psql -d postgres -c "drop database ${DB_NAME}"

db-log-watch:
	tail -f ${LOGFILE}

db-log-kill-watchers:
	kill "`ps aux | grep "[t]ail -f ${LOGFILE}" | awk '{ print $$2 }'`"


###########################################################################
# Cleanup
###########################################################################
very-clean:
	rm -rf ${TMP}


###########################################################################
# Development
###########################################################################
dev-init: pg-init pg-start db-create
dev-cleanup: pg-stop db-log-kill-watchers very-clean

fill-data:
	psql -d ${DB_NAME} < data/txns.sql

refresh: db-drop db-create fill-data

shell:
	psql ${DB_NAME}






