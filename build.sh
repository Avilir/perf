#!/usr/bin/env bash

##############################################################################
#
# This script is for building generic performance container and push it to repository.
# it used the 'podman' for the build and accept the build TAG 
# from the user.
# without the tag the script will stop and exit with error.
# the script must be run from the top directory of the esdump.
#
# the repository that it will create is on quay, but this can be changed.
#
# Author : Avi Liani <alayani@redhat.com>
# Creation date : Mar,04,2021
#
# Updates :
#  Mar,10 2021 - adding abilite for multi-arch
#
##############################################################################

usage() { 
	echo "Usage: $0 [-t <image tag>] -r <repo name> [-m] [-h]" 1>&2
	echo "  -t <image tag> : the tagging of the image - default is 'latest'"
	echo "  -r <repo name> : full repository name including registry site"
	echo "                   e.g. : docker.io/<username>/<repo name>"
	echo "  -m             : create multi-arch image - default is x86_64 only"
	echo "                   multi-arch that avaliable are : x86_64 / ppc64le / s390x"
	echo "  -h             : display this screen"

	exit 1
}

Multi=0
Platforms="linux/amd64,linux/ppc64le,linux/s390x"
CMD_TOOL='docker'  # if you want this can be replace with : 'docker'

while getopts ":t:r:m" o; do
    case "${o}" in
        t)
            Tag=${OPTARG}
            ;;
        r)
            Repo=${OPTARG}
            ;;
	m)  
	    Multi=1
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


if [[ ${Tag} == "" ]] ; then
	echo "no tag provided, going to use 'latest'"
	Tag='latest'
fi

if [[ ${Repo} == "" ]] ; then
	echo "Error: you mast give the Base path for the repository!"
	usage
fi

if [[ ${Multi} -eq 0 ]] ; then
	echo "Building the image for x86_64 Arch only"
	${CMD_TOOL} build --tag ${Repo}:${Tag} .
	${CMD_TOOL} push ${Repo}:${Tag}
else
	echo "Building the image for Multi Arch"
	echo "Going ro run : docker buildx build --push --platform ${Platforms} --tag ${Repo}:${Tag} ."
	docker buildx build --push --platform ${Platforms} --tag ${Repo}:${Tag} .
fi

