#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

indel_result_dir=$script_dir/../out
non_unique_result=$indel_result_dir/left_align_non_unique_with_key
full_data_with_key=$indel_result_dir/original_data_with_key
out_file=$script_dir/../out/analyse_left_align_out

tmp_dir=$script_dir/../tmp
non_unique_result_with_join_key=$tmp_dir/non_unique_result_with_join_key
full_data_with_join_key=$tmp_dir/full_data_with_join_key

#generate key
function create_join_key {
    grep "^[0-9]" $1 | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%02d|%08d|%s\n", $1, $2, $3, $4, $6, $1, substr($2, 1, length($2)-4), $5)}' 
    grep -v "^[0-9]" $1 | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s|%08d|%s\n", $1, $2, $3, $4, $6, $1, substr($2, 1, length($2)-4), $5)}' 
}  

create_join_key $non_unique_result > $non_unique_result_with_join_key
create_join_key $full_data_with_key > $full_data_with_join_key

function join_with_original_data {
    join -t $'\t' -e NULL -1 $2 -2 $2 -a 1 -o 1.5,2.5,1.3,1.4,2.3,2.4,1.2,2.2 <(sort -k$2 $1) <(sort -k$2 $full_data_with_join_key) | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s\t%d\n", $1, $2, $3, $4, $5, $6, $8-$7)}' | grep -Ev '[[:space:]]-[[:digit:]]*$' | uniq -w17 | awk -F $'\t' '{printf("%s\t%s\t%s\t%s\t%s\t%s\n", $1, $2, $3, $4, $5, $6)}' 
}  

echo '#GATK key'$'\t''original key'$'\t''GATK REF'$'\t''GATK ALT'$'\t''original REF'$'\t''original ALT' | awk -F $'\t'  '{printf("%-19s%-19s%-15s%-15s%-50s%-50s\n", $1, $2, $3, $4, $5, $6)}' > $out_file
join_with_original_data $non_unique_result_with_join_key 6 | awk -F $'\t'  '{printf("%-19s%-19s%-15s%-15s%-50s%-50s\n", $1, $2, $3, $4, $5, $6)}' >> $out_file

