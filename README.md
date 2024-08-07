# Description
This repository contains scripts to process necessary geospatial datasets 
and implement efficient zonal statistics on given ESRI Shapefiles. The 
general usage of the script (i.e., `./extract-gis.sh`) is as follows:

```console
Usage:
  extract-gis [options...]

Script options:
  -d, --dataset				Geospatial dataset of interest
  -i, --dataset-dir=DIR			The source path of the dataset file(s)
  -r, --crs=INT				The EPSG code of interest; optional
  					[defaults to 4326]
  -v, --variable=var1[,var2[...]]	If applicable, variables to process
  -o, --output-dir=DIR			Writes processed files to DIR
  -s, --start-date=DATE			If applicable, start date of the geospatial
  					data; optional
  -e, --end-date=DATE			If applicable, end date of the geospatial
  					data; optional
  -l, --lat-lims=REAL,REAL		Latitude's upper and lower bounds; optional
  -n, --lon-lims=REAL,REAL		Longitude's upper and lower bounds; optional
  -f, --shape-file=PATH			Path to the ESRI '.shp' file; optional
  -F, --fid=STR				Column name representing elements of the
  					ESRI Shapefile to report statistics; optional
					defaults to the first column
  -j, --submit-job			Submit the data extraction process as a job
					on the SLURM system; optional
  -t, --print-geotiff=BOOL		Extract the subsetted GeoTIFF file; optional
  					[defaults to 'true']
  -a, --stat=stat1[,stat2[...]]		If applicable, extract the statistics of
  					interest, currently available options are:
					'min';'max';'mean';'majority';'minority';
					'median';'quantile';'variety';'variance';
					'stdev';'coefficient_of_variation';'frac';
					'coords'; 'count'; 'sum'; optional
  -U, --include-na			Include NA values in generated statistics;
  					optional 
  -q, --quantile=q1[,q2[...]]		Quantiles of interest to be produced if 'quantile'
  					is included in the '--stat' argument. The values
					must be comma delimited float numbers between
					0 and 1; optional [defaults to every 5th quantile]
  -p, --prefix=STR			Prefix  prepended to the output files
  -b, --parsable			Parsable SLURM message mainly used
  					for chained job submissions
  -c, --cache=DIR			Path of the cache directory; optional
  -E, --email=STR			E-mail when job starts, ends, and 
  					fails; optional
  -u, --account				Digital Research Alliance of Canada's sponsor's
  					account name; optional, defaults to 'rpp-kshook'
  -L, --lib-path			Path to the shared libraries needed; optional,
  					see the source code for the default path
  -V, --version				Show version
  -h, --help				Show this screen and exit

For bug reports, questions, and discussions open an issue
at https://github.com/kasra-keshavarz/gistool/issues
```


# Available Datasets
|**#**|Dataset                        		   |Time Scale            |CRS  |DOI                    	|Description          |
|-----|--------------------------------------------|----------------------|-----|-------------------------------|---------------------|
|**1**|MODIS			     		   |2000 - 2021           |	|10.5067/MODIS/MCD12Q1.006	|[link](modis)	      |
|**2**|MERIT Hydro		     		   |Not Applicable (N/A)  |4326	|10.1029/2019WR024873		|[link](merit_hydro)  |
|**3**|Soil Grids (v1)				   |Not Applicable (N/A)  |4326	|10.1371/journal.pone.0169748	|[link](soil_grids)   |
|**4**|Landsat NALCMS				   |2010 and 2015	  |4326 |10.3390/rs9111098		|[link](landsat)      |
|**5**|Global Depth to Bedrock			   |Not Applicable (N/A)  |     |10.1002/2016MS000686		|[link](depth_to_bedrock) |
|**6**|USDA Soil Class				   |Not Applicable (N/A)  |4326 |10.4211/hs.1361509511e44adfba814f6950c6e742|[link](soil_class)|
|**7**|Global Soil Dataset for Earth System Modelling (GSDE)|Not Applicable (N/A)|4326 |10.1002/2013MS000293	|[link](GSDE)	      |

# General Example 
As an example, follow the code block below. Please remember that you MUST have access to Graham cluster with Digital Alliance of Canada. Also, remember to generate a [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with GitHub in advance. Enter the following codes in your Graham shell as a test case:

```console
foo@bar:~$ git clone https://github.com/kasra-keshavarz/gistool.git # clone the repository
foo@bar:~$ cd ./gistool/ # always move to the repository's directory
foo@bar:~$ ./extract-gis.sh -h # view the usage message
foo@bar:~$ ./extract-gis.sh \
  --dataset="merit-hydro" \
  --dataset-dir="/project/rpp-kshook/CompHydCore/merit_hydro/raw_data/" \
  --output-dir="$HOME/scratch/merit-hydro-test" \
  --lat-lims="45,47" \
  --lon-lims="-120,-117" \
  --print-geotiff=true \
  --variable="elv,hnd" \
  --prefix="merit_test_";
```
See the [example](./example) directory for real-world scripts for each geospatial dataset included in this repository.


# Logs
The datasets logs are generated under the `$HOME/.gistool` directory,
only in cases where jobs are submitted to clusters' schedulers. If
processing is not submitted as a job, then the logs are printed on screen.


# `--lib-path` options
Currently, on Graham HPC, the following options are available:
```console
/project/rpp-kshook/Climate_Forcing_Data/assets/r-envs/ # default, rpp-kshook allocation
/project/rrg-mclark/lib # rrg-mclark allocation
```


# New Datasets
If you are considering any new dataset to be added to the data repository, 
and subsequently the associated scripts added here, you can open a new 
ticket on the **Issues** tab of the current repository. Or, you can make 
a [Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
on this repository with your own script.


# Support
Please open a new ticket on the **Issues** tab of the current repository in case of any problem.


# License
Geospatial Dataset Processing Workflow<br>
Copyright (C) 2022-2023, University of Saskatchewan<br>
Copyright (C) 2023-2024, University of Calgary<br>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

