#!/bin/bash

log(){
	# $1 is the Log that will Display
	echo "[INFO] $1" >&2
}


err(){
	# $1 is the Error that will Display
	echo "[ERROR] $1" >&2
}


build_push_image(){
	local tag=$1
	local directory=$2

	log "Starting $directory build..."
	docker builder build --no-cache -t "$tag" "./$directory"
	if [ $? -eq 0 ]; then
		log "Building of $directory Image Success :)"

		log "Pushing $directory Image...."
		docker image push "$tag"
		if [ $? -eq 0 ]; then
			log "Pushing of $directory Image Success :)"
		else
			err "Pushing of $directory Image Failed :("
			exit 1
		fi
	else
		err "Building of $directory Image Failed :("
		exit 1
	fi	
}

# Execution for all services
build_push_image "zaher2004/atsea-appserver:v1.0" "app"
build_push_image "zaher2004/atsea-database:v1.0" "database"
build_push_image "zaher2004/atsea-reverse-proxy:v1.0" "reverse_proxy"
build_push_image "zaher2004/atsea-paymentgateway:v1.0" "payment_gateway"

log "All images have been built and pushed successfully!"
