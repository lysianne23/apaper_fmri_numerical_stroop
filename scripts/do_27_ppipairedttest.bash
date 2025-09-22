#!/bin/tcsh

set topdir = /Volumes/NNU_Targeting/Analysis/GAM/SplittingBlocks
set dirA = ${topdir}
set outdir = ${topdir}/Three_seeds/PPI_Group_ACC                                            

mkdir -p ${outdir}

gen_group_command.py                                                         \
    -command       3dttest++                                                 \
    -write_script  cmd_ttest_lastvsfirstIncongruent_ACC.tcsh                 \
    -prefix        $outdir/paired-t-test                                     \
    -dsets         $dirA/Stp_*/ACC_PPI_Incongruent_results/PPI_corrected.full.stats.Stp_*+tlrc.HEAD \
    -set_labels    PPI_Last_Incongruent_ACC PPI_First_Incongruent_ACC        \
    -subs_betas    'PPI.Last_Incongruent#0_Coef'                             \
                   'PPI.First_Incongruent#0_Coef'                            \
    -options       -paired


