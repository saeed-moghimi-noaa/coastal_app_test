#!/bin/bash --login

export WORKdir=/scratch2/COASTAL/coastal/noscrub/shared/Takis/CoastalApp-WW3-tests/work
export ROOTDIR=/scratch2/COASTAL/coastal/noscrub/shared/Takis/CoastalApp
export EXECnsem=${ROOTDIR}/ALLBIN_INSTALL
#################################

echo "=== In run_all.sh ==="
#

while read regtest	
do
  if [ -n "${regtest:+1}" ]; then
    echo "> Running "${regtest}

    work_dir=${WORKdir:-work}/${regtest}
    if [ -d "${work_dir}" ]; then
      mv -f ${work_dir} ${work_dir}_$(date +"%d%m%Y-%H%M%S")
    fi
    mkdir -p ${work_dir}

    cp -rp ${regtest}/* ${work_dir}/
    ${work_dir}/run_case.sh
  fi
done < regtest_list.dat
