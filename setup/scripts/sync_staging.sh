#!/usr/bin/env bash
set -ex
rsync="rsync -aAHv --delete --numeric-ids"
PROD_HOST={{cops_seafile_prod_host}}
W=$(cd $(dirname $(readlink -f $0))/.. && pwd)
cd "$W"
docker-compose stop -t0 || true
systemctl stop seafile
systemctl stop docker
$rsync $PROD_HOST:/var/lib/docker/volumes/ /var/lib/docker/volumes/
systemctl start docker
systemctl start seafile
# vim:set et sts=4 ts=4 tw=80:
