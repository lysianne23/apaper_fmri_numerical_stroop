#!/bin/tcsh
set topdir = /Volumes_NNU_Targeting/Analysis/GAM/SplittingBlocks
set dirA = ${topdir} 
set outdir = ${topdir}/Group_LastVsFirst_Incongruent                                                  \
    

mkdir -p ${outdir}
gen_group_command.py                                                         \
    -command       3dttest++                                                 \
    -write_script  cmd_ttest_GAM_test.tcsh                                   \
    -prefix        $outdir/paired-t-test                                     \
    -dsets         ${dirA}/Stp_*/Stp_*.results/SplittedBlocks.stats.Stp_*_REML+tlrc.HEAD \
    -set_labels    Last_Incongruent First_Incongruent                        \
    -subs_betas    'LastIncongruent#0_Coef' 'FirstIncongruent#0_Coef'        \
    -options       -paired

#To execute ./do_23_ttest.bash this will generate the command 
# then in the terminal execute the command: tcsh -x cmd_ttest_GAM_test.tcsh
