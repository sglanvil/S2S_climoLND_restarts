#!/bin/bash

for ifil in /glade/scratch/ssfcst/forcing_files/*TPQWL*; do
	echo
	echo $ifil
	ncdump -h $ifil | grep WIND | head -n 1 
done
