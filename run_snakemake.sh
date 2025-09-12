#!/bin/bash
#SBATCH --job-name=WholeGenomeGWAS_resid_filter		                    # Job name
#SBATCH --partition=bothwell_p		                        # Partition (queue) name
#SBATCH --ntasks=1			                            # Single task job
#SBATCH --cpus-per-task=28		                        # Number of cores per task
#SBATCH --mem=150gb			                            # Total memory for job
#SBATCH --time=20:00:00  		                        # Time limit hrs:min:sec
#SBATCH --output=/scratch/jsa72906/log.%j			# Location of standard output and error log files
#SBATCH --mail-user=jsa72906@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL                            # Mail events (BEGIN, END, FAIL, ALL)

set -euo pipefail

cd /work/hblab/jsalab/RhizoPlate/vcf2gwas.jsa.snk

module load BCFtools/1.21-GCC-13.3.0
module load R

snakemake --snakefile vcf2gwas.snk --configfile configRhiz.yml -j 5 --ri

# Python/3.12.3-GCCcore-13.3.0

##########################
# Job failed at some point and CHatGPT said the snakemake directory was locked and recommended the following:
#  interact -p bothwell_p --cpus-per-task=28 --mem=40gb --time=6:00:00
# cd /work/hblab/jsalab/RhizoPlate/vcf2gwas.snk
# # sanity check: make sure no other Snakemake is still running
# squeue -u $USER | grep -i snakemake || true
# ps -u $USER -o pid,cmd | grep -E "[s]nakemake|[g]emma" || true
# # unlock the workflow
# snakemake --snakefile vcf2gwas.snk --configfile configRhiz.yml --unlock