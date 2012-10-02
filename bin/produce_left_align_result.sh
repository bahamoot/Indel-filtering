#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

data_dir=~/development/scilifelab/master_data
non_unique_out_with_key=$script_dir/../out/left_align_non_unique_with_key
full_data_with_key=$script_dir/../out/full_left_align_with_key
gatk=~/development/scilifelab/tools/GenomeAnalysisTK-1.4-13-gef50e77/GenomeAnalysisTK.jar

tmp_dir=$script_dir/../tmp
tmp_data_with_key=$tmp_dir/tmp_data_with_key


java -Xmx2g -jar $gatk -R $data_dir/reference/Homo_sapiens.GRCh37.57.dna.concat.fa -T LeftAlignVariants --variant $data_dir/200danes/vcf/SRR028812.var.flt.vcf -o $tmp_dir/left_align_out_12.vcf
java -Xmx2g -jar $gatk -R $data_dir/reference/Homo_sapiens.GRCh37.57.dna.concat.fa -T LeftAlignVariants --variant $data_dir/200danes/vcf/SRR028813.var.flt.vcf -o $tmp_dir/left_align_out_13.vcf

$script_dir/create_group_key.sh $tmp_dir/left_align_out_12.vcf 1 > $tmp_data_with_key
$script_dir/create_group_key.sh $tmp_dir/left_align_out_13.vcf 2 >> $tmp_data_with_key

sort $tmp_data_with_key -k6 | uniq -f6 | uniq -D -f7 > $non_unique_out_with_key
sort $tmp_data_with_key -k6 > $full_data_with_key


#hbvdb_bin=~/development/scilifelab/projects/hbvdb/bin
#data_dir=~/development/scilifelab/master_data
#out_file=$scriptdir/../out/left_align_out
#tmp_dir=$scriptdir/../tmp
#
#if [ -e $hbvdb_bin/DB/bvdb ]
#then
#	rm $hbvdb_bin/DB/*
#	rmdir $hbvdb_bin/DB/
#fi
#
#java -Xmx2g -jar $gatk -R $data_dir/reference/Homo_sapiens.GRCh37.57.dna.concat.fa -T LeftAlignVariants --variant $data_dir/200danes/vcf/SRR028812.var.flt.vcf -o $tmp_dir/left_align_out_12.vcf
#java -Xmx2g -jar $gatk -R $data_dir/reference/Homo_sapiens.GRCh37.57.dna.concat.fa -T LeftAlignVariants --variant $data_dir/200danes/vcf/SRR028813.var.flt.vcf -o $tmp_dir/left_align_out_13.vcf
#
#$hbvdb_bin/bvd-add.pl $tmp_dir/left_align_out_12.vcf
#$hbvdb_bin/bvd-add.pl $tmp_dir/left_align_out_13.vcf
#
#$hbvdb_bin/bvd-get.pl | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$1"|"$2"|"$4}' | uniq -f6 |  awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$1"|"$2}' | uniq -D -f6 |  awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6}' > $out_file



