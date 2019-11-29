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

fish_name = "20191003_GCaMP6_tectum_7dpf_f3"

dataPath = os.path.join("Z:","Elina_backup","zebrafish_data","2p","results",fish_name,"suite2p","combined")


variable_names = ["F", "Fneu", "iscell", "ops", "spks", "stat"]

#%% load variables

for i in range(len(variable_names)):
    full_filename = variable_names[i] + ".npy"
    thisfile = np.load(os.path.join(dataPath,full_filename),allow_pickle = True)
    if i == 0:
        F = thisfile
    elif i == 1:
        Fneu = thisfile
    elif i == 2:
        iscell = thisfile
    elif i == 3:
        ops = thisfile
    elif i == 4:
        spks = thisfile
    elif i == 5:
        stat = thisfile


ops = ops[()]
#%%

plt.subplot(2,1,1)
plt.imshow(F)
plt.show

plt.subplot(2,1,2)
plt.imshow(spks)
plt.show

#mean = np.mean(F)
#
#meanIm = ops["meanImg"]
#
## make a plot of firing rates, where position on y axis indicates ROI position, x axis is time, and size of plot indicates firing rate
#plt.imshow(meanIm)
#plt.show()


#%% plot the ROIs suite2p detected

# for neuron in range(len(stat_pre)):
#     plt.scatter(stat_pre[neuron]["med"][0],stat_pre[neuron]["med"][1],s=iscell_pre[neuron][1])
# plt.show()

