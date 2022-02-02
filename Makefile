test-cpu:
	python test.py --cuda=False 

test-gpu:
	python test.py --cuda=True

evaluate-icdar-2011:
	rm -rf images
	rm -rf crops
	rm -rf results
	cd datasets
	./datasets/download-icdar-validation-sets.sh 2011
	unzip icdar-2011.zip -d ./images/
	cd ..
	python test.py --cuda=True
	zip icdar2011-results.zip result/*.txt

evaluate-icdar-2013:
	rm -rf images
	rm -rf crops
	rm -rf result
	cd datasets
	./datasets/download-icdar-validation-sets.sh 2013
	unzip icdar-2013.zip -d ./images/
	cd ..
	python test.py --cuda=True
	zip icdar2013-results.zip result/*.txt

evaluate-icdar-2015:
	rm -rf images
	rm -rf crops
	rm -rf result
	cd datasets
	./datasets/download-icdar-validation-sets.sh 2015
	unzip icdar-2015.zip -d ./images/
	cd ..
	python test.py --cuda=True
	zip icdar2015-results.zip result/*.txt

run-dev-app:
	FLASK_ENV=development FLASK_APP=./app.py flask run