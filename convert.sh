#! /bin/bash
dir=$1
outname=$2

scriptdir="${0%/*}"

echo "Would you like to delete the individual netCDF files after completion? (y/n)"
read delete

echo "Add time variable? (y/n)"
read addvar

for f in $dir/*g1.h5
do 

    out="$dir/$(basename $f .h5).nc"
    if [ ! -f $out ]; then
        echo "Convert to $out"
        nccopy $f $out
        ncrename -d phony_dim_0,y $out
        ncrename -d phony_dim_1,x $out
        ncrename -d phony_dim_2,z $out
    else
        echo "File $out exists"
    fi
done

echo "Combining files"
ncecat $dir/*g1.nc $outname
ncrename -d record,time $outname

if [ $addvar == 'y' ]; then
    echo "Adding time variable"
    python $scriptdir/times_to_nc.py $dir $outname

else
    echo "Not adding time variable"
fi


if [ $delete == 'y' ]; then
    echo "Removing old files"
    rm -f $dir/*g1.nc

else 
    echo "Not deleting files"

fi

