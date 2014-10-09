#!/bin/bash
# Script for replicating a directory 

# get arguments
target=$1 # the directory we want to replicate
dest=$2 # the place we want to replicate to

usage () {
	echo "Usage:"
	echo ""
	echo "replicator.sh target destination"
	echo ""
	echo "target:       Directory to replicate"
	echo "destination:  Place to replicate to"
	exit
}

# check the args are provided
if [ -z $dest ] || [ ! -z $3 ]; then
	usage
fi

# get the hostname of the system
name=$HOSTNAME

if [ ! -d ${dest}/${name} ]; then
	mkdir ${dest}/${name}
fi

rsync -rp $target ${dest}/${name}
