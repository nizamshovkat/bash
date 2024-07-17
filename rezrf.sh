#!/bin/bash

echo "Путь до файла:"
read SOURCE_DIR

echo "Путь куда надо копировать:"
read BACKUP_DIR

echo "Starting backup from $SOURCE_DIR to $BACKUP_DIR"
cp -r $SOURCE_DIR $BACKUP_DIR
echo "Backup completed."
