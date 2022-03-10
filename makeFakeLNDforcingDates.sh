#!/bin/bash

climoDir='/glade/scratch/ssfcst/climoLND_forcingFiles/'

for iyear in {1980..2021}; do
	echo ${iyear}
	for imonth in {01..12}; do
		cp ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.CLIMO-${imonth}.nc ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.${iyear}-${imonth}.nc
		cp ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.CLIMO-${imonth}.nc ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.${iyear}-${imonth}.nc
		cp ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.CLIMO-${imonth}.nc ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.${iyear}-${imonth}.nc
	done
done

