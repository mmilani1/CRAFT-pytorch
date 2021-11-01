# /bin/bash

echo "Downloading craft.pth"
wget --quiet --no-check-certificate 'https://drive.google.com/uc?id=1CJ9RJmsnKoor5tRG8CyptnTYsvNi7ZYv&export=download' -O ./craft.pth

echo
wget --quiet --no-check-certificate 'https://drive.google.com/uc?id=1dg-3qZ-ZTUqTqVrTvKlN-n3ZcxklbdT6&authuser=0&export=download' -O ./craft-refiner.pth
