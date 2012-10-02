#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

data_dir=~/development/scilifelab/master_data
non_unique_out_with_key=$script_dir/../out/basic_non_unique_with_key
full_data_with_key=$script_dir/../out/original_data_with_key

tmp_dir=$script_dir/../tmp
tmp_data_with_key=$tmp_dir/tmp_data_with_key

##clear old data
#if [ -e $tmp_data_with_key ]
#then
#    rm $tmp_data_with_key
#fi
 
$script_dir/create_group_key.sh $data_dir/200danes/vcf/SRR028812.var.flt.vcf 1 > $tmp_data_with_key
$script_dir/create_group_key.sh $data_dir/200danes/vcf/SRR028813.var.flt.vcf 2 >> $tmp_data_with_key

sort $tmp_data_with_key -k6 | uniq -f6 | uniq -D -f7 > $non_unique_out_with_key
sort $tmp_data_with_key -k6 > $full_data_with_key
#hbvdb_bin=~/development/scilifelab/projects/hbvdb/bin
#bvd_get_out_file=$scriptdir/../out/bvd_get_basic_out
#non_unique_out_file=$scriptdir/../out/non_unique_basic_out
#
#if [ -e $hbvdb_bin/DB/bvdb ]
#then
#	rm $hbvdb_bin/DB/*
#	rmdir $hbvdb_bin/DB/
#fi
#
#$hbvdb_bin/bvd-add.pl $data_dir/200danes/vcf/SRR028812.var.flt.vcf
#$hbvdb_bin/bvd-add.pl $data_dir/200danes/vcf/SRR028813.var.flt.vcf
#
#$hbvdb_bin/bvd-get.pl | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$1"|"$2"|"$4}' | uniq -f6 |  awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$1"|"$2}' | uniq -D -f6 |  awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6}' > $non_unique_out_file


