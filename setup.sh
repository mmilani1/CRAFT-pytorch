# /bin/bash

echo 'Extracting pre-trained-model'
tar -xvzf ./weights/pretrained-model.tar.gz

echo 'Initializing Conda Environment' 
conda init bash
conda create env --file requiremets.yml

echo 'Activating new enviroment'
bash -c 'conda activate craft-detector' 
