#! /bin/bash

usage="usage: fetch-tree.sh <source URL> <destination path>"

#If number of arguments not equal to 2, print usage and exit with error.
if [ $# -ne 2] ; then 
    echo >&2 "$usage"
    exit 1
fi

url="$1"
dest="$2"

origurl="$url"
protocol=${url%%:*} 
commit=${url##*#}


cd $(dirname "$dest")
git clone $url $(basename "$dest")
cd "$dest"
git checkout $commit 
hash=$(git show-ref --head | head -n1 |cut -d' ' -f1)
rm -rf .git

echo "$origurl" > "$dest/.origin_url"
echo "$hash" > "$dest/.origin_hash"
chmod 444 "$dest/.origin_url" "$dest/.origin_hash"
