% code to split tiff into the different planes & save maximum intensity
% projection per plane
% do this per fish, both pre and post


%% experiment variables

expDate     = '20191003';
genotype    = 'GCaMP6';
roiName     = 'tectum';
age         = '7dpf';
fishName    = 'f1';
conds       = {'pre'};

dataDir = 'C:\Users\Elina\Dropbox (UCL - SWC)\For Elina\zebrafish data\raw data';

%% fix features

num_images = 209520;
images_per_plane = 34920;   % 209520/6
nPix       = 256;

figure;

for c = 1:length(conds)
    
    thisFileName = strcat(expDate,'_',genotype,'_',roiName,'_',...
        age,'_',conds{c},'_',fishName,'_00001.tif');
    
    %     info        = imfinfo(fullfile(dataDir,thisFileName));
    %     num_images  = numel(info);
    clear info
    
    f1          = 1:6:num_images;
    images_f1   = {};
    f1c         = 0;
    
    f2          = 2:6:num_images;
    images_f2   = {};
    f2c         = 0;
    
    f3          = 3:6:num_images;
    images_f3   = {};
    f3c         = 0;
    
    f4          = 4:6:num_images;
    images_f4   = {};
    f4c         = 0;
    
    f5          = 5:6:num_images;
    images_f5   = {};
    f5c         = 0;
    
    for f = 1:5
        
        tic
        for j = 1:num_images
            
            if ismember(j,f1) && f==1
                f1c = f1c+1;
                images_f1{f1c} = (imread(fullfile(dataDir,thisFileName),j));
                
            elseif ismember(j,f2) && f==2
                f2c = f2c+1;
                images_f2{f2c} = (imread(fullfile(dataDir,thisFileName),j));
                
            elseif ismember(j,f3) && f==3
                f3c = f3c+1;
                images_f3{f3c} = (imread(fullfile(dataDir,thisFileName),j));
                
            elseif ismember(j,f4) && f==4
                f4c = f4c+1;
                images_f4{f4c} = (imread(fullfile(dataDir,thisFileName),j));
                
            elseif ismember(j,f5) && f==5
                f5c = f5c+1;
                images_f5{f5c} = (imread(fullfile(dataDir,thisFileName),j));
            end
            
        end
        toc
        
        subplot(length(conds),5,f);
        switch f
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
        
        clear image
        if ~isempty(images_f1)
            clear images_f1
        end
        if ~isempty(images_f2)
            clear images_f2
        end
        if ~isempty(images_f3)
            clear images_f3
        end
        if ~isempty(images_f4)
            clear images_f4
        end
        if ~isempty(images_f5)
            clear images_f5
        end
    end
    
end