test-cpu:
	python test.py --cuda=False 

test-gpu:
	python test.py --cuda=True
