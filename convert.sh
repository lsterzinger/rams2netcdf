#! /bin/bash
dir=$1
outname=$2
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

echo "Add time variable? (y/n)"
read addvar

if [ $addvar == 'y' ]; then
    echo "Adding time variable"
    python ./times_to_nc.py $dir $outname
fi

echo "Would you like to delete the individual netCDF files? (y/n)"
read delete

if [ $delete == 'y' ]; then
    echo "Removing old files"
    rm -f $dir/*g1.nc

elif [ $delete == 'n' ]; then
    echo "Not deleting files"

else 
    echo "Command not recognized, exiting"

fi

