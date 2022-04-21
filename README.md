# S2S_climoLND_restarts
Forcing-centered approach to making climoLND restarts.

```
Sasha Glanville
March 4, 2022
see old cron script: /glade/u/home/ssfcst/CESM2-Realtime-Forecast/bin/lndboundary.sh
data from rda (only 2012 -2021): /glade/collections/rda/data/ds094.0/YYYY/cdas1 * sfluxgrbf *
working here: /glade/work/ssfcst/sglanvil/
```

## Overall plan
```
0. make land forcing files (Solar, Precip, TPQWL) for 2012-2021
1. make a yearly climatology (12 files per forcing component) of those forcing files
2. make yearly copies of that climatology to stand in for 2012-2021 (fake dates; same 12 months are repeated)
3. do land run for 1980-2021 that uses the climatological (fake dates) forcing files
```

## Note, we removed these files for the climo, because they had issues (probably just needed to rerun):
```
/glade/scratch/ssfcst/forcing_files/clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.2014-02.nc
/glade/scratch/ssfcst/forcing_files/clmforc.NCEPCFSv2.c2019.0.2d.576x1152.TPQWL.2016-04.nc
```

## Making the land run
```
cd /glade/u/home/ssfcst/cesm2_1/cime/scripts

./create_clone --clone /glade/scratch/ssfcst/I2000Clm50BgcCrop.002runRealtime --case /glade/work/ssfcst/sglanvil/I2000Clm50BgcCrop.002runRealtimeClimo 

cd /glade/work/ssfcst/sglanvil/I2000Clm50BgcCrop.002runRealtimeClimo

./xmlchange RUN_REFDIR=/glade/work/ssfcst/sglanvil/1980-01-01-00000/
./xmlchange RUN_REFCASE=I2000Clm50BgcCrop.002run
./xmlchange RUN_REFDATE=1980-01-01
./xmlchange GET_REFCASE=TRUE
./xmlchange RUN_STARTDATE=1980-01-01
./xmlchange STOP_OPTION=nmonths
./xmlchange STOP_N=12
./xmlchange REST_OPTION=ndays
./xmlchange REST_N=1
./xmlchange DOUT_S_SAVE_INTERIM_RESTART_FILES=TRUE
./xmlchange DATM_CLMNCEP_YR_ALIGN=1980
./xmlchange DATM_CLMNCEP_YR_START=1980
./xmlchange DATM_CLMNCEP_YR_END=2021
./xmlchange DATM_MODE=CLMCRUNCEP 
./xmlchange RESUBMIT=41
./xmlchange CONTINUE_RUN=FALSE

### copy the domain file into new forcing file directory
cp /glade/scratch/ssfcst/forcing_files/domain.ncepCFSv2.c2019.0.2d.nc /glade/scratch/ssfcst/climoLND_forcingFiles/

### update user_datm.streams* in case and run directories 
1. change the forcing directory location
sed -i 's/forcing_files/climoLND_forcingFiles/g' user_datm.streams.txt.CLMCRUNCEP.*

2. update the dates available to be 1980-01 thru 2021-12
just use bash loop, echo, then copy/paste

### update user_nl_datm
  streams = "datm.streams.txt.CLMCRUNCEP.Solar 1980 1980 2021",
      "datm.streams.txt.CLMCRUNCEP.Precip 1980 1980 2021",
      "datm.streams.txt.CLMCRUNCEP.TPQW 1980 1980 2021",
      "datm.streams.txt.presaero.clim_2000 1 2000 2000",
      "datm.streams.txt.topo.observed 1 1 1"

### setup and build
./case.setup (maybe do this step earlier)
./case.build --clean
qcmd -- ./case.build 
./case.submit
```

## Cycling the land run
```
cd /glade/u/home/ssfcst/cesm2_1/cime/scripts

./create_clone --clone /glade/scratch/ssfcst/I2000Clm50BgcCrop.002runRealtime --case /glade/work/ssfcst/sglanvil/I2000Clm50BgcCrop.002runRealtimeClimo_contd

cp /glade/scratch/ssfcst/archive/I2000Clm50BgcCrop.002runRealtimeClimo/rest/2021-01-01-00000/* /glade/work/ssfcst/sglanvil/1980-01-01-00000_contd

cd /glade/work/ssfcst/sglanvil/I2000Clm50BgcCrop.002runRealtimeClimo_contd/

./xmlchange RUN_REFDIR=/glade/work/ssfcst/sglanvil/1980-01-01-00000_contd/
./xmlchange RUN_REFCASE=I2000Clm50BgcCrop.002runRealtimeClimo
./xmlchange RUN_REFDATE=2021-01-01
./xmlchange GET_REFCASE=TRUE
./xmlchange RUN_STARTDATE=1980-01-01
./xmlchange STOP_OPTION=nmonths
./xmlchange STOP_N=12
./xmlchange REST_OPTION=nmonths
./xmlchange REST_N=1
./xmlchange DOUT_S_SAVE_INTERIM_RESTART_FILES=TRUE
./xmlchange DATM_CLMNCEP_YR_ALIGN=1980
./xmlchange DATM_CLMNCEP_YR_START=1980
./xmlchange DATM_CLMNCEP_YR_END=2021
./xmlchange DATM_MODE=CLMCRUNCEP 
./xmlchange RESUBMIT=41
./xmlchange CONTINUE_RUN=FALSE

cp /glade/work/ssfcst/sglanvil/S2S_climoLND_restarts/user_datm.streams* .
cp /glade/work/ssfcst/sglanvil/S2S_climoLND_restarts/user_nl_datm .

./case.setup
qcmd -- ./case.build 
./case.submit
```
