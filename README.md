#How to compile CoastalApp

```
#!/bin/bash --login
# ----------------------------------------------------------- 
# Shell Used: BASH shell
# Original Author(s): Saeed Moghimi
# File Creation Date: 09/17/2022
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
# Execute script to perform CoastalApp test runs 
#
# ----------------------------------------------------------- 

export ROOTDIR='/scratch2/COASTAL/coastal/save/Saeed.Moghimi/models/NEMS/tests/CoastalApp_test/temp7/CoastalApp'

############
# Check out codes
git clone --recursive https://github.com/noaa-ocs-modeling/CoastalApp $ROOTDIR
cd $ROOTDIR
git checkout develop_build
git submodule sync
git submodule update --init --recursive


# DDDDDDDDownload parmatis
#TODO add a error message to perform below if not yet for ww3 compilation
#TODO or export the vars ...
#  sh $ROOTDIR/scripts/download_parmetis.sh
# build on hera
# ./build.sh --component "ATMESH WW3 ADCIRC WW3DATA PAHM " --plat hera --compiler intel --clean -2  --thirdparty=parmetis



###OOOOOOOOR pass your own Parmatis
export METIS_PATH=/scratch2/COASTAL/coastal/save/Ali.Abdolali/hpc-stack/parmetis-4.0.3
export PARMETISHOME=$METIS_PATH
./build.sh --component "ATMESH WW3 ADCIRC WW3DATA PAHM " --plat hera --compiler intel --clean -2  #--thirdparty=parmetis

```
