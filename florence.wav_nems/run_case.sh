#!/bin/bash --login

# Contributors: Andre van der Westhuysen
#
# ----------------------------------------------------------- 
# ------------- Program Description and Details ------------- 
# ----------------------------------------------------------- 
#
# Job Card to set the resources required for a NSEM run
#
# ----------------------------------------------------------- 

#SBATCH --account=coastal
#SBATCH --job-name=fl_wav_nems
#SBATCH -q batch
#SBATCH --time=06:30:00
#SBATCH --ntasks=180
#SBATCH --nodes=15                    # Number of nodes
#SBATCH --ntasks-per-node=12         # How many tasks on each node
#SBATCH --mail-user=saeed.moghimi@noaa.gov
#SBATCH --mail-type=ALL
#SBATCH --output=fl_wav_nems.out.log
#SBATCH --error=fl_wav_nems.err.log
# ----------------------------------------------------------- 



ulimit -s unlimited
ulimit -c 0

export OMP_NUM_THREADS=1
export KMP_AFFINITY=disabled
export KMP_STACKSIZE=2G
export IOBUF_PARAMS='*:size=1M:count=4:vbuffer_count=4096:prefetch=1'

echo "=== In run_case.sh ==="
#
cd ${WORKdir}

echo "Preparing WW3 inputs..."
${EXECnsem}/ww3_grid ww3_grid.inp > ww3_grid.out
cp -p mod_def.ww3 mod_def.inlet
cp -p mod_def.ww3 mod_def.points

${EXECnsem}/ww3_prnc > ww3_prnc.out
#it generates wind.ww3
mv wind.ww3 wind.inlet

${EXECnsem}/ww3_bounc  > ww3_bounc.out
#it generates nest.ww3
mv nest.ww3 nest.inlet

echo "Running NEMS.x..."
#srun -v --slurmd-debug=4 --mem=3000  ${EXECnsem}/NEMS.x   &> multi.out
#srun -v --slurmd-debug=4 ${EXECnsem}/ww3_multi   &> multi.out
srun -v  ${EXECnsem}/NEMS.x   &> multi.out



