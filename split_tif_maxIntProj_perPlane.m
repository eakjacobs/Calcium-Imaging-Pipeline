% code to split tiff into the different planes & save maximum intensity
% projection per plane
% do this per fish, both pre and post

expDate     = '20191003';
genotype    = 'GCaMP6';
roiName     = 'tectum';
age         = '7dpf';
fishName    = 'f3';
conds       = {'post'};

dataDir = 'C:\Users\Elina\Dropbox (UCL - SWC)\For Elina\zebrafish data\raw data';

figure;

for c = 1:length(conds)
    
    thisFileName = strcat(expDate,'_',genotype,'_',roiName,'_',...
        age,'_',conds{c},'_',fishName,'_00001.tif');
    
    %     info        = imfinfo(fullfile(dataDir,thisFileName));
    %     num_images  = numel(info);
    num_images = 65536;
    clear info
    
    f1          = 1:6:num_images;
    images_f1   = {};
    f1c         = 0;
    
    f2          = 2:6:num_images;
    images_f2   = {};
    f2c         = 0;
    
    f3 = 3:6:num_images;
    images_f3   = {};
    f3c         = 0;
    
    f4 = 4:6:num_images;
    images_f4   = {};
    f4c         = 0;
    
    f5 = 5:6:num_images;
    images_f5   = {};
    f5c         = 0;
    
    tic
    for j = 1:num_images
        
        if ismember(j,f1)
            f1c = f1c+1;
            images_f1{f1c} = imread(fullfile(dataDir,thisFileName),j);
            
        elseif ismember(j,f2)
            f2c = f2c+1;
            images_f2{f2c} = imread(fullfile(dataDir,thisFileName),j);
            
        elseif ismember(j,f3)
            f3c = f3c+1;
            images_f3{f3c} = imread(fullfile(dataDir,thisFileName),j);
            
        elseif ismember(j,f4)
            f4c = f4c+1;
            images_f4{f4c} = imread(fullfile(dataDir,thisFileName),j);
            
        elseif ismember(j,f5)
            f5c = f5c+1;
            images_f5{f5c} = imread(fullfile(dataDir,thisFileName),j);
        end
        
    end
    toc
    
    save(fullfile(dataDir,strcat(expDate,'_',genotype,'_',roiName,'_',...
        age,'_',conds{c},'_',fishName,'_stacks_perPlane')),...
        'images_f1','images_f2','images_f3','images_f4','images_f5');
    
    for s = 1:5
        subplot(length(conds),5,s);
        switch s
            case 1
                image = images_f1;
            case 2
                image = images_f2;
            case 3
                image = images_f3;
            case 4
                image = images_f4;
            case 5
                image = images_f5;
        end
        imshow(max(cat(3,image{1:end}),[],3));
    end
    

    
end

%% save

savefig(fullfile(dataDir,strcat(expDate,'_',genotype,'_',roiName,'_',...
    age,'_',conds{c},'_',fishName,'_maxIntProjection_perPlane.fig')));

