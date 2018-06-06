#!/usr/bin/env bash

OPTIND=1
add_domain=true
update_all=true

output_file=""
verbose=0
domains=()

while getopts "d:h" opt; do
    case "$opt" in
    h|\?)
        echo "-d <domain>"
        exit 0
        ;;
    d)  domains+=($OPTARG)
        ;;
    esac
done

shift $((OPTIND-1))

#[ "${1:-}" = "--" ] && shift

rm ctfr.tmp
touch ctfr.tmp
for domain in "${domains[@]}"
do
   echo "Searching: $domain"
   echo "$domain" >> ctrf.tmp
   docker run --rm --init -v $(pwd)/ctfr.tmp:/app/ctfr.tmp johnpaulada/ctfr -d $domain -o ctfr.tmp &> /dev/null
done

