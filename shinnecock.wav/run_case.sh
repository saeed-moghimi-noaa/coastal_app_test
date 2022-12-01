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
#SBATCH --job-name=sh_wav
#SBATCH -q batch
#SBATCH --time=02:30:00
#SBATCH --ntasks=12
#SBATCH --mem 3000
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank (for hyperthreading)
#SBATCH --mail-user=saeed.moghimi@noaa.gov
#SBATCH --mail-type=ALL
#SBATCH --output=sh_wav.out.log
#SBATCH --error=sh_wav.err.log
#
# ----------------------------------------------------------- 

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
#srun -v --slurmd-debug=4 --mem=3000 ./NEMS.x
srun ${EXECnsem}/NEMS.x  &> multi.out


