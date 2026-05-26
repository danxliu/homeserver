#!/bin/bash

BACKUP_DEST="/mnt/backup_drive/backup"
IMMICH_DIR="/srv/homeserver/immich"

mkdir -p "$BACKUP_DEST/immich"

# Dump the Immich Postgres Database 
echo "Dumping Immich database..."
docker exec -t immich_postgres pg_dumpall -c -U postgres > "$IMMICH_DIR/immich_db_dump.sql"

echo "Syncing Immich data..."
rsync -rtv --delete --exclude 'postgres/' "$IMMICH_DIR/" "$BACKUP_DEST/immich/"

echo "=========================================="
echo "Backup finished successfully on $(date)"
echo "=========================================="
