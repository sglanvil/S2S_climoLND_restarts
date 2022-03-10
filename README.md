# S2S_climoLND_restarts
Forcing-centered approach to making climoLND restarts.

see old cron script: /glade/u/home/ssfcst/CESM2-Realtime-Forecast/bin/lndboundary.sh

data from rda (only 2012 -2021 is available): /glade/collections/rda/data/ds094.0/YYYY/cdas1 * sfluxgrbf *

working here: /glade/work/ssfcst/sglanvil/

0. make land forcing files (components: Solar, Precip, TPQWL) for 2012-2021
1. make a yearly climatology (12 files per forcing component) of those forcing files
2. make yearly copies of that climatology to stand in for 2012-2021 (fake dates)
3. do land run starting for 1980-2021 that uses the climatological (fake dates) forcing files
