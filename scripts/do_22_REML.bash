#!/bin/bash
subj=$1

topdir=/Volumes/NNU_Targeting/Analysis/GAM
SplittedBlocks_analysisdir=${topdir}/SplittingBlocks/${subj}/${subj}.results
Datadir=${topdir}/${subj}/${subj}.results

cd ${Datadir}

3dREMLfit                                                                    \
    -matrix  ${SplittedBlocks_analysisdir}/SplittedBlocks.X.xmat.1D          \
    -input   "pb04.$subj.r01.scale+tlrc.HEAD pb04.$subj.r02.scale+tlrc.HEAD  pb04.$subj.r03.scale+tlrc.HEAD pb04.$subj.r04.scale+tlrc.HEAD" \
    -fout                                                                    \
    -tout                                                                    \
    -Rbuck   ${SplittedBlocks_analysisdir}/SplittedBlocks.stats.${subj}_REML \
    -Rvar    ${SplittedBlocks_analysisdir}/SplittedBlocks.stats.${subj}_REMLvar \
    -Rfitts  ${SplittedBlocks_analysisdir}/SplittedBlocks.fitts.${subj}_REML \
    -Rerrts  ${SplittedBlocks_analysisdir}/SplittedBlocks.errts.${subj}_REML \
    -verb
