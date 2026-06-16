#!/usr/bin/env bash
# Leave only one comment symbol on selected options
# Those with two commets will be ignored:
# The name to show in queue lists for this job:
#SBATCH -J Dorado_herro_inference_LIB009_Qilexilex_Norganelles.sh.sh

# Number of desired cpus (can be in any node):
#SBATCH --ntasks=1

# Number of desired cpus (all in same node):
#SBATCH --cpus-per-task=64

# Amount of RAM needed for this job:
#SBATCH --mem=300gb

# The time the job will be running:
#SBATCH --time=80:00:00

#########GPU#############
#########################
# * request GPU:

# To use GPU, comment out the previous constraint line and uncomment these two following lines.
#SBATCH --constraint=dgx
#SBATCH --gres=gpu:1

# If you need nodes with special features leave only one # in the desired SBATCH constraint line. cal is selected by default:
# * to request any machine without GPU - DEFAULT
##SBATCH --constraint=cal
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

#####################
#####################

lecturas_LIB009='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/2_remove_Organelles/LIB009/paf_methodology/Qilexilex.noOrganelle.fastq'
modelo_celda='/mnt/home/users/forescent_001_upm/jpallares/HOME/modules/dorado_v.1.3.0/dorado-1.3.0-linux-x64/bin/herro-v1'
lecturas_dorado_herro_corregidas='/mnt2/fscratch/users/forescent_001_upm/jpallares/ICIFOR/Quercus_assemblies/4_correction_HERRO/LIB009/directo_without_preprocess'


####un log para el uso de GPUs
gpu_log="$lecturas_dorado_herro_corregidas/gpu_monitor_${SLURM_JOB_ID}.log"

##carpeta de dorado
cd /mnt/home/users/forescent_001_upm/jpallares/HOME/modules/dorado_v.1.3.0/dorado-1.3.0-linux-x64/bin


echo "HOSTNAME: $(hostname)"
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:-not_set}"

(
  while true; do
    echo "===== $(date '+%F %T') =====" >> "$gpu_log"
    nvidia-smi \
      --query-gpu=index,name,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free,temperature.gpu,power.draw \
      --format=csv,noheader,nounits >> "$gpu_log"
    echo "--- processes ---" >> "$gpu_log"
    nvidia-smi \
      --query-compute-apps=gpu_uuid,pid,process_name,used_memory \
      --format=csv,noheader,nounits >> "$gpu_log" 2>/dev/null || true
    echo >> "$gpu_log"
    sleep 600
  done
) &
MONITOR_PID=$!

trap 'kill $MONITOR_PID 2>/dev/null || true' EXIT

export LD_LIBRARY_PATH=/mnt/home/users/forescent_001_upm/jpallares/HOME/modules/dorado_v.1.3.0/dorado-1.3.0-linux-x64/lib

./dorado correct $lecturas_LIB009 --device cuda:0 --threads 64 --infer-threads 3 --model-path $modelo_celda > $lecturas_dorado_herro_corregidas/Qilexilex.LIB009.noOrganelle.herro.fasta



DORADO_EXIT=$?

kill $MONITOR_PID 2>/dev/null || true
wait $MONITOR_PID 2>/dev/null || true

exit $DORADO_EXIT
