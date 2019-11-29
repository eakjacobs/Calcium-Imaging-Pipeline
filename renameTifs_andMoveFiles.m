% script to rename and move tif files from post manipulation to pre folder

expDate     = '20191120';
genotype    = 'GCaMP6';
roiName     = 'tectum';
age         = '7dpf';
fishNames   = {'f1','f2','f3'};
% conds       = {'pre','post'};

totalStacks = 174600;

dataDir = 'Z:\Elina_backup\zebrafish_data\2p\Split_Tiffs';

for f = 1:length(fishNames)
    fishName = fishNames{f};
    
    preFolderName = fullfile(dataDir,strcat(...
        expDate,'_',genotype,'_',roiName,'_',age,...
        '_pre_',fishName,'_00001'));
    postFolderName = fullfile(dataDir,strcat(...
        expDate,'_',genotype,'_',roiName,'_',age,...
        '_post_',fishName,'_00001'));
    
%     switch f
%         case 2
%             start = 109969;
%         otherwise
%             start = 1;
%     end

    for i = 1:totalStacks
        thisTifName = fullfile(postFolderName,...
            strcat(num2str(i.','%06d'),'.tif'));
        if exist(thisTifName)
            newTifName = fullfile(preFolderName,...
                strcat(num2str((i+totalStacks).','%06d'),'.tif'));
            movefile(thisTifName,newTifName)
        end
    end
end