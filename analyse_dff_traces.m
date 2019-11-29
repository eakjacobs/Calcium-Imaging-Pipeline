% analyse dff traces

clear all;

expDate     = '20191120';
genotype    = 'GCaMP6';
roiName     = 'tectum';
age         = '7dpf';
fishNames   = {'f1'};

dataDir         = fullfile('Z:','Elina_backup','zebrafish_data','2p','results');
resFolderName   = 'tectum_dff_traces';
resFileName     = 'Tectum Binary Matrix.csv';

Fs = 10;


for f = 1:length(fishNames)
    thisFish = fishNames{f};
    
    thisResultsDir = fullfile(dataDir,...
        strcat(expDate,'_',genotype,'_',roiName,'_',age,'_',thisFish),...
        resFolderName);
    
    data = csvread(fullfile(thisResultsDir,resFileName));
    
    highpassCutoff   = 0.5; % Hz
    [b100s, a100s]   = butter(2, highpassCutoff/(Fs/2), 'low');
    filtered_data    = filter(b100s,a100s,data,[],2);
    
    total_frames    = size(data,2);
    frames_perCond  = total_frames/2;
    
    avgActivity_perNeuron_pre  = nanmean(filtered_data(:,1:frames_perCond),2);
    avgActivity_perNeuron_post = nanmean(filtered_data(:,frames_perCond+1:end),2);
    
    max_act = max(max(avgActivity_perNeuron_pre(:)),max(avgActivity_perNeuron_post(:)));
    
    modulation = avgActivity_perNeuron_post./avgActivity_perNeuron_pre;
    
    [mod_counts, edges] = histcounts(modulation);
    midpoint = find(edges==1);
    n_decrease = sum(mod_counts(1:midpoint-1))
    n_increase = sum(mod_counts(midpoint+2:end))
    n_equal    = sum(mod_counts(midpoint:midpoint+1))
    
    percent_decrease = n_decrease/size(data,1)*100
    percent_inrease  = n_increase/size(data,1)*100
    percent_equal    = n_equal/size(data,1)*100
        
    figure;
    suptitle(thisFish)
    subplot(1,2,1)
    plot([0 max_act],[0 max_act],'k:'); hold on;
    plot(avgActivity_perNeuron_pre,avgActivity_perNeuron_post,'o');
    xlabel('pre');
    ylabel('post');
    title('mean activity per neuron');
    axis square;
    
    subplot(1,2,2)
    histogram(modulation,120); hold on;  
    title('modulation index');
    axis square
    
    
    pause;
end

