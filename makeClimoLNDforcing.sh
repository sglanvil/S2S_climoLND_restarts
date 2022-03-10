#!/bin/bash

inDir='/glade/scratch/ssfcst/forcing_files/'
outDir='/glade/scratch/ssfcst/climoLND_forcingFiles/'

mkdir -p ${outDir}

for imonth in {01..12}; do
	echo ${imonth}
	ncra -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.*-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.CLIMO-${imonth}.nc
	ncra -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.*-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.CLIMO-${imonth}.nc
	ncra -O ${inDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.*-${imonth}.nc ${outDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.CLIMO-${imonth}.nc
done

