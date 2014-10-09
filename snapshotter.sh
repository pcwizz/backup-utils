#!/usr/local/bin/bash
# Script to rotate ones snapshots

# Get arguments
target=$1 # the dataset to snapshot
family=$2 # the prefixed name of the snapshot eg weekly
keep=$3 # the number of snapshots to keep

yourDoingItWrong() {
	echo "This is is how you do it\n"
	echo "snapshotter.sh target family keep\n"
	echo "e.g. snapshotter.sh tank hourly 48\n"
	exit
}

# Check the inputs there

if [ -z $keep ] || [ ! -z $4 ]; then
	yourDoingItWrong
fi

keep=$(($keep - 1)) # well we count from 0

# prune
zfs list -t snapshot | grep -q ^${target}@${family}\.${keep}
if [ $? -eq 0 ]; then # if we have all the snapshots we want
	zfs destroy -r ${target}@${family}.${keep} # get rid of one to make room
fi

# Rename existing snapshots
while [ $keep -gt 0 ] ; do
	src=$(($keep - 1))
	zfs list -t snapshot | grep -q ^${target}@${family}\.${src}
	if [ $? -eq 0 ] ; then
    		zfs rename -r ${target}@${family}.${src} ${target}@${family}.${keep}
   	fi
   	keep=$(($keep - 1))
done

# replace the one we removed
zfs snapshot -r ${target}@${family}.0
