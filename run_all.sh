#!/bin/bash
# ----------------------------------------------------------- 
# UNIX Shell Script File
# Tested Operating System(s): RHEL 7
# Tested Run Level(s): 
# Shell Used: BASH shell
# Original Author(s): Andre van der Westhuysen
# File Creation Date: 05/15/2020
# Date Last Modified:
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

echo "=== In run_all.sh ==="
#
while read regtest	
do
   echo "> Running "${regtest}
   export WORKdir=/scratch2/COASTAL/coastal/noscrub/shared/Saeed.Moghimi/coastalapp_test/rerun-andre/CoastalApp-WW3-tests/work/${regtest}
   mkdir -p ${WORKdir}
   cp -p ${regtest}/* ${WORKdir}/
   ${WORKdir}/run_case.sh
done < regtest_list.dat
