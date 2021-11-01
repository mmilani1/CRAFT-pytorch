import torch

print('Cuda Available?:', torch.cuda.is_available())

print('Current Devaice:', torch.cuda.current_device())

print('Device:', torch.cuda.device(0))

print('Device Count:', torch.cuda.device_count())

print('Device Name:' torch.cuda.get_device_name(0))
