# -*- coding: utf-8 -*-
"""
Created on Wed Nov 13 19:08:16 2019

scipt to look at the output from suite2p

@author: Elina
"""
import os
import numpy as np
import matplotlib.pyplot as plt

#dataPath = os.path.join("C:","Users","Elina","Dropbox (UCL - SWC)","ForElina","zebrafish_data","Elina zebrafish data")

fish_name = "20191003_GCaMP6_tectum_7dpf_f1"
#condition_1 = "pre"
#condition_2 = "post"


variable_names = ["F", "Fneu", "iscell", "ops", "spks", "stat"]

#%% load variables

for c in range(1,3):
    if c == int(1):
        cond = condition_1
    elif c == int(2):
        cond = condition_2
        
    for i in range(len(variable_names)):
        full_filename = fish_name + " " + cond + " - " + variable_names[i] + ".npy"
        thisfile = np.load(os.path.join(dataPath,full_filename),allow_pickle = True)
        if c == 1:
            if i == 0:
                F_pre = thisfile
            elif i == 1:
                Fneu_pre = thisfile
            elif i == 2:
                iscell_pre = thisfile
            elif i == 3:
                ops_pre = thisfile
            elif i == 4:
                spks_pre = thisfile
            elif i == 5:
                stat_pre = thisfile
        elif c == 2:
            if i == 0:
                F_post = thisfile
            elif i == 1:
                Fneu_post = thisfile
            elif i == 2:
                iscell_post = thisfile
            elif i == 3:
                ops_post = thisfile
            elif i == 4:
                spks_post = thisfile
            elif i == 5:
                stat_post = thisfile
                
ops_pre = ops_pre[()]
ops_post = ops_post[()]
                
#%%

mean_pre = np.mean(F_pre)
mean_post = np.mean(F_post)

meanIm_pre = ops_pre["meanImg"]
meanIm_post = ops_post["meanImg"]
                
# make a plot of firing rates, where position on y axis indicates ROI position, x axis is time, and size of plot indicates firing rate
plt.subplot(2,1,1)
plt.imshow(meanIm_pre)
plt.show()

plt.subplot(2,1,2)
plt.imshow(meanIm_post)
plt.show()

#%% plot the ROIs suite2p detected

for neuron in range(len(stat_pre)):
    plt.scatter(stat_pre[neuron]["med"][0],stat_pre[neuron]["med"][1],s=iscell_pre[neuron][1])
plt.show()
