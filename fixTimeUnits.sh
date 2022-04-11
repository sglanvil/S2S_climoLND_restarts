#!/bin/bash

climoDir='/glade/scratch/ssfcst/climoLND_forcingFiles/'

for iyear in {1980..2021}; do
        echo ${iyear}
        for imonth in {01..12}; do
                ncap2 -O -s "time@units=\"days since ${iyear}-${imonth}-01 00:00:00\"" ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.${iyear}-${imonth}.nc ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.${iyear}-${imonth}.nc

                ncap2 -O -s "time@units=\"days since ${iyear}-${imonth}-01 00:00:00\"" ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.${iyear}-${imonth}.nc ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Precip.${iyear}-${imonth}.nc

                ncap2 -O -s "time@units=\"days since ${iyear}-${imonth}-01 00:00:00\"" ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.${iyear}-${imonth}.nc ${climoDir}clmforc.NCEPCFSv2.c2019.0.2d.576x1152.Solar.${iyear}-${imonth}.nc
        done
done
