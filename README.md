# RAMS files to netCDF

These scripts convert a folder of RAMS HDF5 files to a single netCDF file with proper dimensions and a time variable.

```bash
$ ./convert.sh ./data_folder/ output_file.nc
```

Python Requirements:
* Python 3
* netCDF4
* ramslibs

ramslibs can be installed via `pip install ramslibs`
