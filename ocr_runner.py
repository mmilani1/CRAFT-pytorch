import sys
import os
import time
import argparse

import torch
import torch.nn as nn
import torch.backends.cudnn as cudnn
from torch.autograd import Variable

from PIL import Image

import cv2
from skimage import io
import numpy as np
import craft_utils
import imgproc
import file_utils
import json
import zipfile

from craft import CRAFT
from crnn.demo import predict

class OcrRunner:
    def __init__(self, is_cuda=False):
        self.is_cuda = is_cuda
        self.trained_model = './weights/craft.pth'
        self.text_threshold = 0.7
        self.low_text = 0.45
        self.link_threshold = 0.4
        self.canvas_size = 1920
        self.mag_ratio = 1.5
        self.refiner_model = './weights/craft-refiner.pth'

    def run(self, image_path):
        net = CRAFT()     # initialize

        print('Loading weights from checkpoint (' + self.trained_model + ')')
        if self.is_cuda:
            net.load_state_dict(self.__copyStateDict(torch.load(self.trained_model)))
        else:
            net.load_state_dict(self.__copyStateDict(torch.load(self.trained_model, map_location='cpu')))

        if self.is_cuda:
            net = net.cuda()
            net = torch.nn.DataParallel(net)
            cudnn.benchmark = False

        image = imgproc.loadImage(image_path)

        bboxes, polys = self.__run_detection(net, image, self.text_threshold, self.link_threshold, self.low_text)
        words = [predict(imgproc.crop_bbox(image, box)) for box in polys]

        return words

    def __run_detection(self, net, image, text_threshold, link_threshold, low_text):
        # resize
        img_resized, target_ratio, size_heatmap = imgproc.resize_aspect_ratio(image, self.canvas_size, interpolation=cv2.INTER_LINEAR, mag_ratio=self.mag_ratio)
        ratio_h = ratio_w = 1 / target_ratio

        # preprocessing
        x = imgproc.normalizeMeanVariance(img_resized)
        x = torch.from_numpy(x).permute(2, 0, 1)    # [h, w, c] to [c, h, w]
        x = Variable(x.unsqueeze(0))                # [c, h, w] to [b, c, h, w]
        if self.is_cuda:
            x = x.cuda()

        # forward pass
        with torch.no_grad():
            y, feature = net(x)

        # make score and link map
        score_text = y[0,:,:,0].cpu().data.numpy()
        score_link = y[0,:,:,1].cpu().data.numpy()

        # Post-processing
        boxes, polys = craft_utils.getDetBoxes(score_text, score_link, text_threshold, link_threshold, low_text, False)

        # coordinate adjustment
        boxes = craft_utils.adjustResultCoordinates(boxes, ratio_w, ratio_h)
        polys = craft_utils.adjustResultCoordinates(polys, ratio_w, ratio_h)
        for k in range(len(polys)):
            if polys[k] is None: polys[k] = boxes[k]

        return boxes, polys

    def __copyStateDict(self, state_dict):
        from collections import OrderedDict

        if list(state_dict.keys())[0].startswith("module"):
            start_idx = 1
        else:
            start_idx = 0
        new_state_dict = OrderedDict()
        for k, v in state_dict.items():
            name = ".".join(k.split(".")[start_idx:])
            new_state_dict[name] = v
        return new_state_dict
