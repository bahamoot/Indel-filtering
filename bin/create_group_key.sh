#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

hbvdb_bin=~/development/scilifelab/projects/hbvdb/bin
tmp_bvd_get=$script_dir/../tmp/tmp_bvd_get

if [ -e $hbvdb_bin/DB/bvdb ]
then
	rm $hbvdb_bin/DB/*
	rmdir $hbvdb_bin/DB/
fi

$hbvdb_bin/bvd-add.pl $1
$hbvdb_bin/bvd-get.pl > $tmp_bvd_get 

grep "^[0-9]" $tmp_bvd_get | awk -F $' ' -v i=$2 '{printf("%s\t%s\t%s\t%s\t%s\t%02d|%012d|%s\t%02d|%012d|%s\t%02d|%012d\n", $1, $2, $4, $5, i, $1, $2, i, $1, $2, $4, $1, $2)}' 
grep -v "^[0-9]" $tmp_bvd_get | awk -F $' ' -v i=$2 '{printf("%s\t%s\t%s\t%s\t%s\t%s|%012d|%s\t%s|%012d|%s\t%s|%012d\n", $1, $2, $4, $5, i, $1, $2, i, $1, $2, $4, $1, $2)}' 

#tmp_dir=$scriptdir/../tmp
#tmp_key=$tmp_dir/tmp_key
#tmp_data_with_key=$tmp_dir/tmp_data_with_key
#
##clear old data
#if [ -e $tmp_key ]
#then
#    rm $tmp_key
#fi
#if [ -e $tmp_data_with_key ]
#then
#    rm $tmp_data_with_key
#fi
#
#grep "^[0-9]" $1 | awk -F $'\t' '{printf("%02d|%012d\n", $1, $2)}' | uniq >> $tmp_key
#grep -v "^[0-9]" $1 | awk -F $'\t' '{printf("%s|%012d\n", $1, $2)}' | uniq >> $tmp_key
#
#grep "^[0-9]" $1 | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s\t%02d|%012d\t%02d|%08d\n", $1, $2, $3, $4, $5, $6, $1, $2, $1, substr($2, 1, length($2)-4))}' >> $tmp_data_with_key
#grep -v "^[0-9]" $1 | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s\t%s|%012d\t%02d|%08d\n", $1, $2, $3, $4, $5, $6, $1, $2, $1, substr($2, 1, length($2)-4))}' >> $tmp_data_with_key
#
#
#while read line
#do
#    grep "$line" $tmp_data_with_key | grep -n "$line" | awk -F ':' '{printf("%s\t%s\n", $1, $2)}' | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s\t%s|%s\t%s\t%s\n", $2, $3, $4, $5, $6, $7, $8, $1, $8, $9)}'
#done < $tmp_key

