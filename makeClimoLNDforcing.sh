#!/bin/bash

inDir='/glade/scratch/ssfcst/forcing_files/'
outDir='/glade/scratch/ssfcst/climoLND_forcingFiles/'

mkdir -p ${outDir}

#for imonth in {01..12}; do
#	echo ${imonth}
#	ncra -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.*-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.CLIMO-${imonth}.nc
#	ncra -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.*-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.CLIMO-${imonth}.nc
#	ncra -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.*-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.CLIMO-${imonth}.nc
#done

# the above stuff was a hella mistake, so redo:
for ivar in Solar TPQWL Precip; do
	echo ${ivar}
	for imonth in {01..12}; do
		echo ${imonth}
		ncecat -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.${ivar}.????-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.${ivar}.ALL-${imonth}.nc
		ncwa -O -a record ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.${ivar}.ALL-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.${ivar}.CLIMO-${imonth}.nc
		ncks  --mk_rec_dmn time -O ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.${ivar}.CLIMO-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.${ivar}.CLIMO-${imonth}.nc 
	done
done

