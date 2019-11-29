% create maximum and mean activity images for images that have already been
% split

expDate     = '20191003';
genotype    = 'GCaMP6';
roiName     = 'tectum';
age         = '7dpf';
fishName    = 'f2';
cond        = 'post';

nPlanes     = 5;            % number of z planes
totalStacks = 174600;
imSize      = [256,256];

dataDir = 'Z:\Elina_backup\zebrafish_data\2p';

thisExpFolderName = strcat(expDate,'_',genotype,'_',roiName,'_',age,'_',...
    cond,'_',fishName,'_00001');

% figure;
% suptitle([expDate ' ' roiName ' ' fishName ' ' cond])

for z = 3:nPlanes
    
    stackInds = z:nPlanes:totalStacks;
    fullStack = zeros(imSize(1),imSize(2),length(stackInds),'uint16');
    
    % this step takes about 8 minutes
    parfor i = 1:length(stackInds)
        thisInd = stackInds(i);
        thisTifName = strcat(num2str(thisInd.','%06d'),'.tif');
        fullStack(:,:,i) = uint16(imread(fullfile(dataDir,'Split_Tiffs',thisExpFolderName,thisTifName)));
    end
    
    % this takes about 2 minutes to save
    save(fullfile(dataDir,'Split_Tiffs',thisExpFolderName,...
        strcat('plane',num2str(z),'_fullStack.mat')),'fullStack','-v7.3');
    
    subplot(2,nPlanes,z)
    imagesc(mean(fullStack,3)); axis off; axis square, caxis([0 2000]);
    title('mean');
    subplot(2,nPlanes,z+nPlanes)
    imagesc(max(fullStack,[],3)); axis off; axis square; caxis([1500 15000])
    title('max');
    
end

savefig(fullfile(dataDir,'results',...
    strcat(expDate,'_',roiName,'_',fishName,'_',cond,'_mean_and_max_perPlane')));