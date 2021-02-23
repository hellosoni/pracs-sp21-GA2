#!/bin/bash
#SBATCH --account=PAS1855
#SBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
set -u -e -o pipefail

date
module load python/3.6-conda5.2
source activate cutadaptenv

#8.Let the script take 4 arguments that can be passed to it on the command-line
#The path to a FASTQ file with forward reads
R1_in="$1"
echo "Path to forward read file $R1_in"
#The name of the output directory for trimmed FASTQ files
output_dir="$2"
echo "Output directory $output_dir"
mkdir -p results/trim
#The sequence of the forward & reverse primers
primer_f="$3"
primer_r="$4"
echo "Forward primer $primer_f"
echo "Reverse primer $primer_r"

#9. Compute the reverse complement for each primer
primer_f_rc=$(echo "$primer_f" | tr ATCGYRKMBVDH TAGCRYMKVBHD | rev)
primer_r_rc=$(echo "$primer_r" | tr ATCGYRKMBVDH TAGCRYMKVBHD | rev)

#10.Infer corresponding reverve read file:
R2_in=$(echo $R1_in | sed 's/R1/R2/')
echo "Reverse read file $R2_in"

#11. Assign output file paths (output dir + file name) for the R1 and R2 output file:
R1_out=$output_dir/$(basename $R1_in ".fastq")_trimmed.fastq
R2_out=$output_dir/$(basename $R2_in ".fastq")_trimmed.fastq
echo "Trimmed forward read $R1_out"
echo "Trimmed reverse read $R2_out"

#12.Create the output directory? Already did?

#13. call to the Cutadapt program
cutadapt -a "$primer_f"..."$primer_f_rc" \
    -A "$primer_r"..."$primer_r_rc" \
    --discard-untrimmed --pair-filter=any \
    -o "$R1_out" -p "$R2_out" "$R1_in" "$R2_in"