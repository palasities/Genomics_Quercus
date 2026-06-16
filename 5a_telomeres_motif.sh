#!/usr/bin/env bash
# Leave only one comment symbol on selected options
# Those with two commets will be ignored:
# The name to show in queue lists for this job:
#SBATCH -J seqkt_telo_LIB008.sh

# Number of desired cpus (can be in any node):
#SBATCH --ntasks=1

# Number of desired cpus (all in same node):
#SBATCH --cpus-per-task=10

# Amount of RAM needed for this job:
#SBATCH --mem=40gb

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


cd /mnt/home/users/forescent_001_upm/jpallares/HOME/modules/seqtk/seqtk

assembly_LIB008='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/5_Verkko/LIB008_QilexrotunONT'
outy='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/5a_telomeres/LIB008'

./seqtk telo -m CCCTAAA $assembly_LIB008/assembly.fasta > $outy/telomeres_CCCTAAA.bed 2> $outy/telomeres_CCCTAAA.count
./seqtk telo -m TTTAGGG $assembly_LIB008/assembly.fasta > $outy/telomeres_TTTAGGG.bed 2> $outy/telomeres_TTTAGGG.count
