#!/usr/bin/env bash
# Leave only one comment symbol on selected options
# Those with two commets will be ignored:
# The name to show in queue lists for this job:
#SBATCH -J Map_Qilexilex_LIB009_to_Organelles_QilexMITandballotaCLOR_PAF.sh

# Number of desired cpus (can be in any node):
#SBATCH --ntasks=1

# Number of desired cpus (all in same node):
#SBATCH --cpus-per-task=60

# Amount of RAM needed for this job:
#SBATCH --mem=100gb

# The time the job will be running:
#SBATCH --time=168:00:00

# To use GPUs you have to request them:
##SBATCH --gres=gpu:1

# If you need nodes with special features leave only one # in the desired SBATCH constraint line. cal is selected by default:
# * to request any machine without GPU - DEFAULT
#SBATCH --constraint=cal
# * to request only the machines with 128 cores and 1800GB of usable RAM
##SBATCH --constraint=bigmem
# * to request only the machines with 128 cores and 450GB of usable RAM (
##SBATCH --constraint=sr
# * to request only the machines with 52 cores and 187GB of usable RAM (
##SBATCH --constraint=sd

# Set output and error files
#SBATCH --error=job.%J_paf.err
#SBATCH --output=job.%J_paf.out

# Leave one comment in following line to make an array job. Then N jobs will be launched. In each one SLURM_ARRAY_TASK_ID will take one value from 1 to 100
##SBATCH --array=1-100

# To load some software (you can show the list with 'module avail'):

# the program to execute with its parameters:


module load samtools/1.3.1
module load minimap2/2.24

Organelles='/mnt/home/users/forescent_001_upm/jpallares/fscratch/ICIFOR/Quercus_assemblies/Organelles_references/Q_ilex_ilex_Mt1_Mt2_and_Q_ilex_ballota_Clor.fasta'
Index_minimap='/mnt/home/users/forescent_001_upm/jpallares/fscratch/ICIFOR/Quercus_assemblies/Organelles_references'
fastq_Qilex_ilex='/mnt/home/users/forescent_001_upm/jpallares/fscratch/ICIFOR/Basecalling/SUP/LIB009/20260105_1511_P2S-03446-A_PBI11910_58779400/fastq_pass/PBI11910_pass_58779400_8737f54b_0.fastq'


minimap2 -t 50 -x map-ont "$Index_minimap/Organelles.mmi" "$fastq_Qilex_ilex" > organelle_map_Qilexilex.paf

##after minimap2 run:

awk '{
  qlen=$2;
  qspan=($4-$3);          # span sobre la read
  aln=$11;                # aligned block length
  ident=$10/$11;          # identity aprox
  mapq=$12;

  if(ident>=0.95 && mapq>=30 && (aln>=5000 || qspan/qlen>=0.80)) print $1
}' organelle_map_Qilexilex.paf | sort -u > organelle.reads_5k_MAPQ30_identity95.ids

