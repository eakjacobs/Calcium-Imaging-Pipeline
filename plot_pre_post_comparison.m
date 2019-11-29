% load pre and post stack images

%% experiment variables

expDate     = '20191003';
genotype    = 'GCaMP6';
roiName     = 'tectum';
age         = '7dpf';
fishName    = 'f3';

dataDir = 'C:\Users\Elina\Dropbox (UCL - SWC)\For Elina\zebrafish data\raw data';

%% load results
load(fullfile(dataDir,...
    strcat(expDate,'_',genotype,'_',roiName,'_',age,...
    '_pre_',fishName,'_stacks_perPlane.mat')));
max_pre_1 = max(cat(3,images_f1{1:end}),[],3);
max_pre_2 = max(cat(3,images_f2{1:end}),[],3);
max_pre_3 = max(cat(3,images_f3{1:end}),[],3);
max_pre_4 = max(cat(3,images_f4{1:end}),[],3);
max_pre_5 = max(cat(3,images_f5{1:end}),[],3);
clear images_f1 images_f2 images_f3 images_f4 images_f5

load(fullfile(dataDir,...
    strcat(expDate,'_',genotype,'_',roiName,'_',age,...
    '_post_',fishName,'_stacks_perPlane.mat')));
max_post_1 = max(cat(3,images_f1{1:end}),[],3);
max_post_2 = max(cat(3,images_f2{1:end}),[],3);
max_post_3 = max(cat(3,images_f3{1:end}),[],3);
max_post_4 = max(cat(3,images_f4{1:end}),[],3);
max_post_5 = max(cat(3,images_f5{1:end}),[],3);
clear images_f1 images_f2 images_f3 images_f4 images_f5

%% figure

figure;
subplot(2,5,1)
imagesc(max_pre_1); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);
title('Pre');

subplot(2,5,2)
imagesc(max_pre_2); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);

subplot(2,5,3)
imagesc(max_pre_3); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);

subplot(2,5,4)
imagesc(max_pre_4); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);

subplot(2,5,5)
imagesc(max_pre_5); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);


subplot(2,5,6)
imagesc(max_post_1); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);
title('Post');

subplot(2,5,7)
imagesc(max_post_2); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);

subplot(2,5,8)
imagesc(max_post_3); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);

subplot(2,5,9)
imagesc(max_post_4); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);

subplot(2,5,10)
imagesc(max_post_5); axis square; axis off;
caxis([maxF*0.1 maxF*0.9]); colormap(hot);


figure;
cmap = RedWhiteBlue;
subplot(1,5,1)
imagesc([max_pre_1 - max_post_1]); axis square, axis off;
caxis([-22000*0.75 22000*0.75]); colormap(cmap);
title('pre - post');

subplot(1,5,2)
imagesc([max_pre_2 - max_post_2]); axis square, axis off;
caxis([-22000*0.75 22000*0.75]); colormap(cmap);

subplot(1,5,3)
imagesc([max_pre_3 - max_post_3]); axis square, axis off;
caxis([-22000*0.75 22000*0.75]); colormap(cmap);

subplot(1,5,4)
imagesc([max_pre_4 - max_post_4]); axis square, axis off;
caxis([-22000*0.75 22000*0.75]); colormap(cmap);

subplot(1,5,5)
imagesc([max_pre_5 - max_post_5]); axis square, axis off;
caxis([-22000*0.75 22000*0.75]); colormap(cmap);
