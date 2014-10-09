Backup Utils
============
A collection of scripts That I use to keep my data safe.
--------------------------------------------------------

### snapshotter.sh

Is an auto rotation script for zfs.

### replicator.sh

Is a wrapper around rsync to replicate directories, to a folder inside a folder with the hostname, so backing up multiple machines doesn't get messy.

### General use

Make some crontab entries for the script. I replicate to an nfs mount of the dataset I snapshot.

### License

These scripts are licensed under GPL3.

