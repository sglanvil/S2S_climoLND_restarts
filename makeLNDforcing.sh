#!/usr/bin/env bash 
source ~/.bash_profile
module load ncl
cd /glade/u/home/ssfcst/CESM2-Realtime-Forecast

iyear=2014
imonth=04
#for iyear in {2013..2019}; do
#	for imonth in {01..12}; do
		sg_date=$iyear-$imonth
		echo $sg_date
		./bin/getCDASdata.py --date $sg_date
		rm /glade/scratch/ssfcst/cdas_data/*0229*
		export CYLC_TASK_CYCLE_POINT=$sg_date
		ncl ./bin/create_landforcing_from_NCEPCFC.ncl
#	done
#done


