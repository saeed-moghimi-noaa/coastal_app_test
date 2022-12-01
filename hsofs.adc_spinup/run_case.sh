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
#SBATCH --job-name=fl_tide_spin
#SBATCH -q batch
#SBATCH --time=06:30:00
#SBATCH --ntasks=720
#SBATCH --mem 3000
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank (for hyperthreading)
#SBATCH --mail-user=saeed.moghimi@noaa.gov
#SBATCH --mail-type=ALL
#SBATCH --output=fl_tide_spin.out.log
#SBATCH --error=fl_tide_spin.err.log
# ----------------------------------------------------------- 

echo "=== In run_case.sh ==="
#
cd ${WORKdir}

echo "Preparing ADCIRC inputs..."
${EXECnsem}/adcprep --np 720 --partmesh >  adcprep.log
${EXECnsem}/adcprep --np 720 --prepall  >> adcprep.log

echo "Running NEMS.x..."
#srun -v --slurmd-debug=4 --mem=3000 ./NEMS.x
srun ${EXECnsem}/NEMS.x  &> nems.out

