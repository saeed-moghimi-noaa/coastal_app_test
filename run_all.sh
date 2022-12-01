#!/bin/bash
# ----------------------------------------------------------- 
# UNIX Shell Script File
# Tested Operating System(s): RHEL 7
# Tested Run Level(s): 
# Shell Used: BASH shell
# Original Author(s): Andre van der Westhuysen
# File Creation Date: 05/15/2020
# Date Last Modified: 01/12/2022 Saeed Moghimi
#
# Version control: 1.00
#
# Support Team:
#
# Contributors: 
#
# ----------------------------------------------------------- 
# ------------- Program Description and Details ------------- 
# ----------------------------------------------------------- 
#
# Script to call NEMS.x executable for forecast run
#
# ----------------------------------------------------------- 


export WRKdir=/scratch2/COASTAL/coastal/noscrub/shared/Saeed.Moghimi/coastalapp_test/rerun-andre/CoastalApp-WW3-tests/work
export ROOTDIR=/scratch2/COASTAL/coastal/noscrub/shared/Saeed.Moghimi/coastalapp_test/rerun-andre/tmp/CoastalApp/
export HSOFSDATA=/scratch2/COASTAL/coastal/noscrub/shared/Saeed.Moghimi/coastalapp_test/rerun-andre/CoastalApp-WW3-tests/hsofs-data/
#################################

#   for fl in `ls ${HSOFSDATA}`;   do 
#      echo ${HSOFSDATA}/${fl} 
#   done


export EXECnsem=${ROOTDIR}/ALLBIN_INSTALL/
source ${ROOTDIR}/modulefiles/envmodules_intel.hera
module list


echo "=== In run_all_hsofs.sh ==="

name="hsofs"

#
while read regtest	
do
   echo "> Running "${regtest}
   export WORKdir=${WRKdir}/${regtest}
   mkdir -p ${WORKdir}
   cp -p ${regtest}/*     ${WORKdir}/
     
   if [[ "${regtest}" == *"$name"* ]]; then  
     cp -s ${HSOFSDATA}/*   ${WORKdir}/
   fi
   sbatch ${WORKdir}/run_case.sh
done < regtest_list.dat
