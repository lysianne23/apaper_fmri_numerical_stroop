#!/bin/bash

#Name:         cmd.ppi.1.get_timeseries_GAM.sh
# Author:      LB - Using template from Rick's PPI script on AFNI
# Date:        03/21/24
# Syntax:      ./cmd.ppi.1.get_timeseries_GAM.sh LL
# Arguments:   subj: subject ID

# Description: This script will get the time series of the seeds of interest 
#     Requirements:                                                          
#     1)AFNI                                                                 
#     2)This script needs to be run after  defining                         
#     the seeds for the PPI,those are from the paired t-test from do_23_test.bash
#			Extracted seeds were left ACC, right ACC, right dorsal ACC.


if [ "$#" -eq 1 ]; then
   subj=$1
else
   echo "Specify participant ID Please"
   exit 1
fi

topdir=/Volumes/NNU_Targeting/Analysis/GAM
PPIdir=${topdir}/SplittingBlocks/${subj}/ACC_PPI_Incongruent
APP_Resultsdir=${topdir}/${subj}/${subj}.results
Maskdir=/Volumes/NNU_Targeting/Scripts/PPI_on_GAM
mkdir -p ${PPIdir}

##This section allows to extract the time series before they were censored in the APP script
3dTproject                                                                   \
    -ort     ${APP_Resultsdir}/X.nocensor.xmat.1D                            \
    -input   ${APP_Resultsdir}/all_runs.${subj}+tlrc                         \
    -prefix  ${PPIdir}/errts.nocensor.${subj}

## Generate the ppi seed time series:
## it uses the time series from APP and the mask from the group analysis     \
3dmaskave                                                                    \
    -quiet                                                                   \
    -mask   ${Maskdir}/rightACC+tlrc ${PPIdir}/errts.nocensor.${subj}+tlrc >  \
            ${PPIdir}/ppi.rightACC${subj}.1D
3dmaskave                                                                    \
    -quiet                                                                   \
    -mask   ${Maskdir}/leftACC+tlrc ${PPIdir}/errts.nocensor.${subj}+tlrc >  \
            ${PPIdir}/ppi.leftACC${subj}.1D
3dmaskave                                                                    \
    -quiet                                                                   \
    -mask   ${Maskdir}/dACC+tlrc ${PPIdir}/errts.nocensor.${subj}+tlrc >     \
            ${PPIdir}/ppi.dACC${subj}.1D
 