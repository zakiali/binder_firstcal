#! /bin/bash 

usage="$0 <aipy> <omnical> <capo>" 

if [ $# -ne 3 ]; then 
    echo >&2 "$usage"
    exit 1
fi

aipy_url="$1"
omnical_url="$2"
capo_url="$3"

specdir=$(dirname $0)
if [ ! -f $specdir/Dockerfile ]; then
    echo >&2 "error: \"$specdir/Dockerfile\" should exist but doesn't"
    exit 1
fi

imagename=firstcal:$(date +%Y%m%d)

DOCKER="docker"

set -e 
work=$(mktemp -d ${TMPDIR:-/tmp}/firstcal.XXXXXX)
echo "Temporary work directory is $work ."
mkdir ${work}/firstcal
$specdir/fetch-tree.sh $aipy_url $work/firstcal/aipy
$specdir/fetch-tree.sh $omincal_url $work/firstcal/omnical
$specdir/fetch-tree.sh $capo_url $work/firstcal/capo
(cd $specdir && cp -a * .dockerignore $work)
$DOCKER build -t $imagename $work
echo "Built image $imagename ."
$DOCKER tag -f $imagename ${imagename%:*}:latest
rm -rf work 
exit 0

