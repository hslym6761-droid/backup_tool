# Backup Tool

A simple automated backup tool written in Bash.

This tool creates compressed backups of a specified directory and stores them in a backup directory. It can be automated using a systemd service and timer.

## Features

- Create compressed `.tar.gz` backups
- Automatic backup using systemd
- Scheduled backups using systemd timer
- Automatic cleanup of old backups
- Backup activity logging
- Simple Bash implementation
