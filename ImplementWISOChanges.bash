#!/bin/bash

WISOChangesDir="wiso-changes"

WPSVersion="WPS-4.7.0" # "WPS-4.7.0"
WRFVersion="WRFV4.8.0" # "WRFV4.8.0"

WPSTarget="WPS-4.7.0"
WRFTarget="WRFV4.8.0"

# Check that we have wiso code for the specified versions.
if [[ ! -d "$WISOChangesDir/$WPSVersion" ]]; then
    echo "We do not have water isotope modifications for $WPSVersion."
    error_code=1
fi

if [[ ! -d "$WISOChangesDir/$WRFVersion" ]]; then
    echo "We do not have water isotope modifications for $WRFVersion."
    error_code=1
fi

# Check that the target directories exist
if [[ ! -d "$WPSTarget" ]]; then
    echo "Target WPS directory, $WPSTarget, does not exist."
    error_code=1
fi

if [[ ! -d "$WRFTarget" ]]; then
    echo "Target WRF directory, $WRFTarget, does not exist."
    error_code=1
fi

if [[ error_code -eq 1 ]]; then
   echo "Stopping now ..."
   exit 9
fi
   
######## WPS Changes #########
pushd $WISOChangesDir/$WPSVersion/
# Figure out how to make list object
ListOfFiles=(`find * -type f`)

popd

echo "======="
echo "Updating the following WPS files with isotope-enabled versions.  Old copy saved as .PreWISO*."

# loop through list object
for file in "${ListOfFiles[@]}"; do
    echo ${file}
    echo "mv $WPSTarget/${file} $WPSTarget/${file}_PreWISO_$(date +%Y-%m-%d_%H%M%S)"
    echo "mv $WISOChangesDir/$WPSVersion/${file} $WPSTarget/${file}"
echo "  "
done
echo "  "

######## WRF Changes #########
pushd $WISOChangesDir/$WRFVersion/
# Figure out how to make list object
ListOfFiles=(`find * -type f`)

popd

echo "======="
echo "Updating the following WRF files with isotope-enabled versions.  Old copy saved as .PreWISO*."

# loop through list object
for file in "${ListOfFiles[@]}"; do
    echo ${file}
    echo "mv $WRFTarget/${file} $WRFTarget/${file}_PreWISO_$(date +%Y-%m-%d_%H%M%S)"
    echo "mv $WISOChangesDir/$WRFVersion/${file} $WRFTarget/${file}"
echo "  "
done
echo "  "

