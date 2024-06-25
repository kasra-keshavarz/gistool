#!/bin/bash

# Geospatial Dataset Processing Workflow
# Copyright (C) 2022-2023, University of Saskatchewan
# Copyright (C) 2023-2024, University of Calgary
#
# This file is part of the Geospatial Dataset Processing Workflow
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This is a simple example to extract common statistics for the extents 
# of pfaf 71 - Saskatchewan-Nelson System Shapefiles of MERIT-Basin
#
# If you have a Shapefile containing polygons, you may able to use
# the `--shapefile` argument to provide the Shapefile instead of spatial
# limits. 
#
# If you would like to extract zonal statistics out of polygons, you can
# use the following options as an example:
#    --stat="mean,min,max,median,quantile" \
#    --quantile="0.1,0.5,0.9" \

# Always call the script in the root directory of this repository
cd ..
echo "The current directory is: $(pwd)"

# Example 1: implement subsetting and zonal statistics on 2010 and 2015 landcover datasets
./extract-gis.sh --dataset="landsat" \
  --dataset-dir="/project/rpp-kshook/Model_Output/Landsat/" \
  --variable="land-cover" \
  --lat-lims="44,60" \
  --lon-lims="-118,-78" \
  --print-geotiff=true \
  --output-dir="$HOME/scratch/landsat-test/" \
  --prefix="landsat_test_" \
  --start-date=2010 \
  --end-date=2015 \
  --email=your-email@company.ca \
  -j;

# Example 2: implement zonal statistics for the 2010-2015 differences 
#	     GeoTIFFs (see relevant landsat directory of this repository)
./extract-gis.sh --dataset="landsat" \
  --dataset-dir="/project/rpp-kshook/Model_Output/Landsat/" \
  --variable="land-cover-change" \
  --print-geotiff=false \
  --lat-lims="44,60" \
  --lon-lims="-118,-78" \
  --output-dir="$HOME/scratch/landsat-test/" \
  --prefix="landsat_test_" \
  --email=your-email@company.ca \
  -j;
