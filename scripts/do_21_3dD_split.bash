#!/bin/bash

#set subj = Stroop_1
subj=$1

topdir=/Volumes/NNU_Targeting
Datadir=${topdir}/Analysis/GAM/${subj}/${subj}.results
FirstBlocks_stimulidir=${topdir}/Behav/${subj}/FirstBlocks
LastBlocks_stimulidir=${topdir}/Behav/${subj}/LastBlocks
prefix_3dd=SplittedBlocks.
SplittedBlocks_analysisdir=${topdir}/Analysis/GAM/SplittingBlocks/${subj}/${subj}.results

\mkdir -p ${SplittedBlocks_analysisdir}
echo ${SplittedBlocks_analysisdir}

3dDeconvolve                                                                 \
    -input           ${Datadir}/pb04.${subj}.r01.scale+tlrc.HEAD             \
                     ${Datadir}/pb04.${subj}.r02.scale+tlrc.HEAD             \
                     ${Datadir}/pb04.${subj}.r03.scale+tlrc.HEAD             \
                     ${Datadir}/pb04.${subj}.r04.scale+tlrc.HEAD             \
    -censor          ${Datadir}/censor_${subj}_combined_2.1D                 \
    -ortvec          ${Datadir}/mot_demean.r01.1D ${Datadir}/mot_demean_r01  \
    -ortvec          ${Datadir}/mot_demean.r02.1D ${Datadir}/mot_demean_r02  \
    -ortvec          ${Datadir}/mot_demean.r03.1D ${Datadir}/mot_demean_r03  \
    -ortvec          ${Datadir}/mot_demean.r04.1D ${Datadir}/mot_demean_r04  \
    -polort          3                                                       \
    -num_stimts      4                                                       \
    -stim_times      1                                                       \
                     ${FirstBlocks_stimulidir}/First_Congruent_Corr_${subj}_Onset.txt \
                     'GAM'                                                   \
    -stim_label      1 FirstCongruent                                        \
    -stim_times      2                                                       \
                     ${FirstBlocks_stimulidir}/First_Incongruent_Corr_${subj}_Onset.txt \
                     'GAM'                                                   \
    -stim_label      2 FirstIncongruent                                      \
    -stim_times      3                                                       \
                     ${LastBlocks_stimulidir}/Congruent_Corr_${subj}_Onset.txt \
                     'GAM'                                                   \
    -stim_label      3 LastCongruent                                         \
    -stim_times      4                                                       \
                     ${LastBlocks_stimulidir}/Incongruent_Corr_${subj}_Onset.txt \
                     'GAM'                                                   \
    -stim_label      4 LastIncongruent                                       \
    -jobs            16                                                      \
    -gltsym          'SYM: +FirstIncongruent -FirstCongruent'                \
    -gltsym          'SYM: +LastIncongruent -LastCongruent'                  \
    -gltsym          'SYM: +LastIncongruent -FirstIncongruent'               \
    -gltsym          'SYM: +LastCongruent -FirstCongruent'                   \
    -glt_label       1 First_IncongruentVSCongruent                          \
    -glt_label       2 Last_IncongruentVSCongruent                           \
    -glt_label       3 Last_IncongruentVSFirst_Incongruent                   \
    -glt_label       4 Last_CongruentVSFirst_Congruent                       \
    -fout                                                                    \
    -tout                                                                    \
    -x1D             ${SplittedBlocks_analysisdir}/${prefix_3dd}X.xmat.1D    \
    -xjpeg           ${SplittedBlocks_analysisdir}/${prefix_3dd}X.jpg        \
    -x1D_uncensored  ${SplittedBlocks_analysisdir}/${prefix_3dd}X.nocensor.xmat.1D \
    -fitts           ${SplittedBlocks_analysisdir}/${prefix_3dd}fitts.${subj} \
    -errts           ${SplittedBlocks_analysisdir}/${prefix_3dd}errts.${subj} \
    -bucket          ${SplittedBlocks_analysisdir}/${prefix_3dd}stats.${subj}

exit 0
