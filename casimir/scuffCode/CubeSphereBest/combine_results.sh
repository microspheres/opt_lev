#!/bin/bash

dirs=$(ls | grep "BeadCube_" | grep -v "T-")
ext=".out"
printf "%7s %7s %12s %12s %12s %12s %s\n" L Grid Energy EnergyErr Force ForceErr Status
for dir in $dirs
do
    files=$dir/*$ext
    L=$(echo $dir | cut -d 'L' -f 2 | cut -d '-' -f 2 | cut -d '_' -f 1)
    grid=$(echo $dir | cut -d 'd' -f 3 | cut -d '-' -f 2 | cut -d 'b' -f 1 | cut -d '.' -f 1,2 | cut -d '_' -f 1)
    for file in $files
    do
	if [ -f $file ] 
	then
	    line=$(tail -n 1 $file | awk '{print $2" "$3" "$4" "$5}')
	    if [ -z "$line" ]
	    then
		printf "%7.3f %7.3f %12.3e %12.3e %12.3e %12.3e %4i\n" $L $grid 0 0 0 0 2
	    else
		printf "%7.3f %7.3f %12.3e %12.3e %12.3e %12.3e %4i\n" $L $grid $line 0
	    fi
	else
	    printf "%7.3f %7.3f %12.3e %12.3e %12.3e %12.3e %4i\n" $L $grid 0 0 0 0 1
	fi
    done
done
