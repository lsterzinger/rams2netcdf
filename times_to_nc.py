from netCDF4 import Dataset, date2num
from ramslibs.data_tools import flist_to_times
import sys
from glob import glob
import os
from datetime import datetime

dir = sys.argv[1]
fname = sys.argv[2]

cwd = os.getcwd()
os.chdir(dir)

flist = sorted(glob("*g1.nc"))
tarr = flist_to_times(flist)

os.chdir(cwd)
f = Dataset(fname, 'r+')

time_out = f.createVariable('time', 'f8', ['time'])
time_out.units = "hours since 0001-01-01 00:00:00.0"
time_out.calendar = "gregorian"

time_out[:] = date2num(
    tarr.astype(datetime),
    units=time_out.units,
    calendar=time_out.calendar
)
f.close()
