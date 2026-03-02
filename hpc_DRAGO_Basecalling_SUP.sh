#!/bin/bash

#SBATCH -J dorado_basecaller_LIB009_SUP.sh
#SBATCH -p gpu # Partición (cola)
#SBATCH -N 1 # Numero de nodos
#SBATCH -n 1 # Numero de cores(CPUs)
#SBATCH --cpus-per-task=16  ##añado  numero de threads
#SBATCH --gres=gpu:1 # SOLO en particion gpu, se pide cualquier tipo de gpu

##SBATCH --gres=gpu:a100:1 # SOLO en particion gpu, se pide una gpu Nvidia A100

##SBATCH --gres=gpu:h200:1 # SOLO en particion gpu, se pide una gpu Nvidia H200

#SBATCH --mem 100G # Bloque de memoria para todos los nodos
#SBATCH -t 2-00:00 # Duración (D-HH:MM)
#SBATCH -o slurm.%N,%jdorado_LIB009_SUP.out #STDOUT
#SBATCH -e slurm.%N,%jdorado_LIB009_SUP.err #STDERR
#SBATCH --mail-type=BEGIN,END,FAIL # Notificación cuando el trabajo empieza,termina o falla
#SBATCH --mail-user=jorge.pallares@inia.csic.es # Enviar correo a la dirección

##drivers utilizados
module load dorado/0.9.1-CUDA-12.1.1

# Ahora fuerza tu Dorado 1.3.1 (local) por delante
export DORADO_HOME=/lustre/home/icifor/jpallares/modules/dorado/dorado-1.3.1-linux-x64
export PATH="$DORADO_HOME/bin:$PATH"

# (Opcional) si por algún motivo tu binario no encuentra libs, añade CUDA explícito:
# echo "CUDA_HOME=$CUDA_HOME"
# export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"

echo "Which dorado: $(which dorado)"
dorado --version
nvidia-smi

# Ejecuta

POD5='/lustre/scratch-global/icifor/jpallares/Librerias/LIB009/pod5'
FASTQ='/lustre/scratch-global/icifor/jpallares/Basecalling/LIB009'
model="$DORADO_HOME/models"


dorado basecaller $model/dna_r10.4.1_e8.2_400bps_sup@v5.2.0 $POD5/ \
  --device cuda:all  \
  --output-dir $FASTQ \
  --emit-fastq \
  --min-qscore 7
