#!/bin/tcsh

set subj = $1
set topdir = /data/NNU_Targeting/Analysis/GAM/SplittingBlocks/${subj}/ACC_PPI_Incongruent_results
set prefix_3dd =  ${topdir}/PPI_corrected.full.
set stimuli = /data/NNU_Targeting/Behav/${subj}/FirstandLast

set input = /data/NNU_Targeting/Analysis/GAM/${subj}/${subj}.results
set ppiinput = ${topdir} 
                                                                      
module load afni
# ------------------------------

# run the regression analysis
3dDeconvolve                                                                 \
    -input           ${input}/pb04.$subj.r*.scale+tlrc.HEAD                  \
    -censor          ${input}/motion_${subj}_censor.1D                       \
    -ortvec          ${input}/motion_demean.1D mot_demean                    \
    -polort          3                                                       \
    -num_stimts      9                                                       \
    -stim_times      1 ${stimuli}/First_C*.txt 'GAM'                         \
    -stim_label      1 First_Congruent                                       \
    -stim_times      2 ${stimuli}/First_I*.txt 'GAM'                         \
    -stim_label      2 First_Incongruent                                     \
    -stim_times      3 ${stimuli}/Last_C*.txt 'GAM'                          \
    -stim_label      3 Last_Congruent                                        \
    -stim_times      4 ${stimuli}/Last_I*.txt 'GAM'                          \
    -stim_label      4 Last_Incongruent                                      \
    -stim_file       5 ${ppiinput}/p6.ACC.01.First_Congruent.rall.PPI.1D     \
    -stim_label      5 PPI.First_Congruent                                   \
    -stim_file       6 ${ppiinput}/p6.ACC.02.First_Incongruent.rall.PPI.1D   \
    -stim_label      6 PPI.First_Incongruent                                 \
    -stim_file       7 ${ppiinput}/p6.ACC.03.Last_Congruent.rall.PPI.1D      \
    -stim_label      7 PPI.Last_Congruent                                    \
    -stim_file       8 ${ppiinput}/p6.ACC.04.Last_Incongruent.rall.PPI.1D    \
    -stim_label      8 PPI.Last_Incongruent                                  \
    -stim_file       9 ${ppiinput}/ppi.ACC_seed_${subj}.1D                   \
    -stim_label      9 PPI.seed                                              \
    -jobs            16                                                      \
    -gltsym          'SYM: 1*PPI.Last_Incongruent -1*PPI.First_Incongruent'  \
    -glt_label       1 PPI:LastIncongruent_vs_FirstIncongruent               \
    -gltsym          'SYM: 1*PPI.Last_Congruent -1*PPI.First_Congruent'      \
    -glt_label       2 PPI:LastCongruent_vs_FirstCongruent                   \
    -fout                                                                    \
    -tout                                                                    \
    -x1D             ${prefix_3dd}X.xmat.1D                                  \
    -xjpeg           ${prefix_3dd}X.jpg                                      \
    -x1D_uncensored  ${prefix_3dd}X.nocensor.xmat.1D                         \
    -errts           ${prefix_3dd}errts.${subj}                              \
    -bucket          ${prefix_3dd}stats.$subj


