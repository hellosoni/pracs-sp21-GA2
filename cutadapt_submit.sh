
R1_in=/fs/ess/PAS1855/users/nghi/week06/pracs-sp21-GA2/data/FASTQ/201-S4-V4-V5_S53_L001_R1_001.fastq
output_dir=/fs/ess/PAS1855/users/nghi/week06/pracs-sp21-GA2/results/trim
primer_f="GAGTGYCAGCMGCCGCGGTAA"
primer_r="TTACCGCGGCKGCTGRCACTC"
./cutadapt_single.sh $R1_in $output_dir $primer_f $primer_r

