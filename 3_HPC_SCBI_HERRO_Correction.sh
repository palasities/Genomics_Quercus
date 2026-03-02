#!/usr/bin/env bash
# Leave only one comment symbol on selected options
# Those with two commets will be ignored:
# The name to show in queue lists for this job:
#SBATCH -J 0_preprocess_HERRO_LIB009.sh

# Number of desired cpus (can be in any node):
#SBATCH --ntasks=1

# Number of desired cpus (all in same node):
#SBATCH --cpus-per-task=100

# Amount of RAM needed for this job:
#SBATCH --mem=400gb

# The time the job will be running:
#SBATCH --time=68:00:00

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
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

# Leave one comment in following line to make an array job. Then N jobs will be launched. In each one SLURM_ARRAY_TASK_ID will take one value from 1 to 100
##SBATCH --array=1-100


# To load some software (you can show the list with 'module avail'):

module load seqkit ##needed

# the program to execute with its parameters:

##IMPORTANT TO ADD PORECHOP absolute path to preprocess script!

program='/mnt/home/users/forescent_001_upm/jpallares/HOME/modules/HERRO_ONT_correction/herro/scripts'
noOrganelles='/mnt/home/users/forescent_001_upm/jpallares/fscratch/ICIFOR/Quercus_assemblies/2_remove_Organelles/LIB009/paf_methodology/Qilexilex.noOrganelle.fastq'

##scripts/preprocess.sh <input_fastq> <output_prefix> <number_of_threads> <parts_to_split_job_into>

$program/preprocess.sh $noOrganelles /mnt/home/users/forescent_001_upm/jpallares/fscratch/ICIFOR/Quercus_assemblies/4_correction_HERRO/LIB009/1_preprocess/Qilexilex 100 5
