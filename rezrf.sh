#/bin/bash
SOURCE_DIR="/home/shovkat/text.txt"
BACKUP_DIR="/home/shovkat/backup"

echo "Starting backup from $SOURCE_DIR to $BACKUP_DIR"
cp -r $SOURCE_DIR $BACKUP_DIR
echo "Backup completed."