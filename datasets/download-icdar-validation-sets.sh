#!/bin/bash

ICDAR_VERSION=$1

if [[ $ICDAR_VERSION == 2011 ]]; then

    echo "Downloading ICDAR 2011 validation images"
    wget --quiet --no-check-certificate 'https://drive.google.com/uc?id=1rAdvLsuZiyhdPnYaIOdgidR-oLVNLZ_E&authuser=0&export=download' -O ./icdar-2011.zip

elif [[ $ICDAR_VERSION == 2013 ]]; then

    echo "Downloading ICDAR 2013 validation images"
    wget --quiet --no-check-certificate 'https://drive.google.com/uc?id=1PEf2tzkdEH4M7ifKDWy7gpxFKhTFAiXP&authuser=0&export=download' -O ./icdar-2013.zip

elif [[ $ICDAR_VERSION == 2015 ]]; then

    echo "Downloading ICDAR 2015 validation images"
    wget --quiet --no-check-certificate 'https://drive.google.com/uc?id=1AWWoGEN8w7FdPgJc-_AHa8j1TDdg74kX&authuser=0&export=download' -O ./icdar-2015.zip

else

    echo "$ICDAR_VERSION is not suported"

fi
