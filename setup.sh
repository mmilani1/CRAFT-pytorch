# /bin/bash

echo 'Initializing Conda Environment' 
conda init bash
conda create env --file requiremets.yml

echo 'Activating new enviroment'
bash -c 'conda activate craft-detector' 
