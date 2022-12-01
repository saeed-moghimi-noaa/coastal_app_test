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
#SBATCH --job-name=sh_atm2ocn
#SBATCH -q batch
#SBATCH --time=02:30:00
#SBATCH --ntasks=12
#SBATCH --mem 3000
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank (for hyperthreading)
#SBATCH --mail-user=saeed.moghimi@noaa.gov
#SBATCH --mail-type=ALL
#SBATCH --output=sh_atm2ocn.out.log
#SBATCH --error=sh_atm2ocn.err.log
#
# ----------------------------------------------------------- 
# ------------- Program Description and Details ------------- 
# ----------------------------------------------------------- 
#
# Script to call NEMS.x executable for forecast run
#
# ----------------------------------------------------------- 

echo "=== In run_case.sh ==="
#
cd ${WORKdir}

echo "Preparing ADCIRC inputs..."
${EXECnsem}/adcprep --np 11 --partmesh >  adcprep.log
${EXECnsem}/adcprep --np 11 --prepall  >> adcprep.log

echo "Running NEMS.x..."
#srun -v --slurmd-debug=4 --mem=3000 ./NEMS.x
srun ${EXECnsem}/NEMS.x  &> nems.out

