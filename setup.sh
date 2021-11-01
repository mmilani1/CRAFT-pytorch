# /bin/bash

echo 'Checking for pre-trained models'
if [[ -f "./weights/craft.pth" ]] && [[ -f "./weights/craft.pth" ]]; then
    echo 'Pre-trained models found!'
else
    echo 'Downloading pre-trained-model'
    cd weights
    bash download-pre-trained.sh
    cd ..
fi;

echo "Checking for conda"
if ! command -v conda &> /dev/null
then
    echo "conda could not be found"
    exit
fi

echo 'Initializing Conda Environment' 
conda init bash
conda env create --file requirements.yml

echo 'Activating new enviroment'
bash -i -c "conda activate craft-detector"
