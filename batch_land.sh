#!/bin/bash
#PBS -N landForcing
#PBS -j oe
#PBS -M ssfcst@ucar.edu
#PBS -l select=1:ncpus=1:mpiprocs=1:mem=100GB
#PBS -A CESM0020
#PBS -l walltime=12:00:00
#PBS -q casper

cd /glade/work/ssfcst/sglanvil/
bash makeLandForcing.sh

