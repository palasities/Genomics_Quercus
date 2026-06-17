#!/usr/bin/env bash
# Leave only one comment symbol on selected options
# Those with two commets will be ignored:
# The name to show in queue lists for this job:
#SBATCH -J verkko_LIB009_assembly.sh

# Number of desired cpus (can be in any node):
#SBATCH --ntasks=1

# Number of desired cpus (all in same node):
#SBATCH --cpus-per-task=120

# Amount of RAM needed for this job:
#SBATCH --mem=300gb

# The time the job will be running:
#SBATCH --time=168:00:00

#########GPU#############
#########################
# * request GPU:

# To use GPU, comment out the previous constraint line and uncomment these two following lines.
##SBATCH --constraint=dgx
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

module load verkko/2.3

#####################
#####################

resultados_LIB009='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/5_Verkko/LIB009_QilexilexONT'
herro_ont='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/4_correction_HERRO/LIB009/directo_without_preprocess/Qilexilex.LIB009.noOrganelle.herro.fasta'
uncorrected_ont='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/2_remove_Organelles/LIB009/paf_methodology/Qilexilex.noOrganelle.fastq'


verkko -d $resultados_LIB009 --hifi $herro_ont --nano $uncorrected_ont --no-correction --local-memory 250 --local-cpus 115
