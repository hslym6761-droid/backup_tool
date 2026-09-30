#!/usr/bin/env bash
#automatic backup script
#
#
#
SOURCE="/home/hselim/Documents"
DEST="/home/hselim/backups"
LOG_FILE="$DEST/backup.log"
RETENTION_DAYS=7


DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$DEST/backup-$DATE.tar.gz"





log_message() {
	echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1 " >> "$LOG_FILE"
}



check_source() {
	if [ ! -d "$SOURCE" ] ; then
		log_message "ERROR : source directory does not exist : $SOURCE "
		exit 1
	fi
}




prepare_backup_dir() {
	if [ ! -d "$DEST" ] ; then
		mkdir -p "$DEST"

		if [ $? -ne 0 ]; then
			echo "ERROR : can not create backup directory "
			exit 1 
		fi
	fi
}



create_backup() {
	log_message " starting backup "
	log_message " source : $SOURCE "
	log_message " destination : $BACKUP_FILE "
	tar -czf "$BACKUP_FILE" "$SOURCE" 2>> "$LOG_FILE"
	

	if [ $? -eq 0 ]; then
		SIZE=$(du -h "$BACKUP_FILE" | cut -f1)

		log_message "bacukup completed successfuly "
		log_message " backup size : $SIZE "

		echo " backup completed successfuly "
		echo " file : $BAKUP_FILE "
		echo " size : $SIZE "
	else
		log_message "ERROR : backup failed "
		echo " backup fialed "
		exit 1
	fi
}



cleanup_old() {
	log_message "checking old backups ... "

	find "$DEST" \
		-type f \
		-name "backup-*.tar/gz" \
		-mtime +"$RETENTION_DAYS" \
		-delete

	log_message " old backups cleanup copleted "

}





#
#main

prepare_backup_dir


check_source


log_message  " backup process started "


create_backup


cleanup_old

log_message " backup process finished "



echo " backup process finished "


echo " log file " $LOG_FILE "

