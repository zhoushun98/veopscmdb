#! /bin/bash

export PATH=$PATH

DIR=$(cd -P $(dirname $0);pwd)
DIR_BACKUP="$DIR/db-backup"
DATE=$(date +"%Y%m%d")

test -d ${DIR_BACKUP} || mkdir -p ${DIR_BACKUP}

docker exec -i cmdb-db mysqldump -uroot -p123456 --databases cmdb > ${DIR_BACKUP}/cmdb_${DATE}.sql
