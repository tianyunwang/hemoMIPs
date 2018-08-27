#/bin/bash
( grep "@RG" new_header.sam; bwa mem -M -L 80 -C /fast/groups/ag_kircher/hemophilia/scripts/hemomips_inv_ref/hemomips_inv_ref.fa <( samtools view -r ${1} -F 1 sample.bam | awk 'BEGIN{ OFS="\n" }{ if (length($10) >= 75) { print "@"$1" "$12"\t"$13"\t"$14,$10,"+",$11 } }' ) | awk '{ if (($0 ~ /^@/) || ($3 ~ /^inv/)) print }';   bwa mem -M -L 80 -p -C /fast/groups/ag_kircher/hemophilia/scripts/hemomips_inv_ref/hemomips_inv_ref.fa <( samtools view -r ${1} -f 1 sample.bam | awk 'BEGIN{ OFS="\n" }{ print "@"$1" "$12"\t"$13"\t"$14,$10,"+",$11 }' ) | awk '{ if (($0 !~ /^@/) && ($3 ~ /^inv/)) print }' ) | samtools view -b -F 768 - | samtools sort -O bam -o inversion_mips/${1}.bam -