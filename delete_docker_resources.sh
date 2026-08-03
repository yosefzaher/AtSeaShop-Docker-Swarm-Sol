#!/bin/bash

err(){
	echo "[ERROR] $1" >&2
}

log(){
	echo "[INFO] $1" >&2
}

# Remove all Containers
log "Removing Containers...."
containers=$(docker ps -aq)
if [ -n "$containers" ]; then
	docker container rm -f $containers
	log "Containers Removed Successfully !"
else
	log "No Containers to Remove."
fi

# Remove all Images
log "Removing Images...."
images=$(docker image ls -q)
if [ -n "$images" ]; then
	docker image rm -f $images
	log "Images Removed Successfully !"
else
	log "No Images to Remove."
fi

# Remove all Build Cache
log "Removing All Building Cache...."
docker builder prune -a -f
log "All Building Cache Removed Successfully !"


log "All Docker Resources Completely Removed !"
