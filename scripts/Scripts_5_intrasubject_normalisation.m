%% Script 5. Intrasubject normalisation of features
%run on all patients and controls
clear all
%Change to appropriate subject dir
SUBJECTS_DIR = '~/Desktop/MartinTisdall/sEEG_pnts/Freesurfer'
cd(SUBJECTS_DIR)

setenv SUBJECTS_DIR .
addpath /Applications/freesurfer/matlab/

% Subs=dir('FCD_*');
% 
% subs=cell(length(Subs),1);
% for s = 1:length(Subs);
%     subs{s}=Subs(s).name;
% end
% 
% % List any subjects who are excluded eg did not pass quality control.
% Remove={'FCD_3T_1'; 'FCD_3T_4';'FCD_3T_8';'FCD_3T_12';'FCD_3T_18';'FCD_3T_22';...
%     'FCD_3T_28';'FCD_3T_34';'FCD_3T_35';'FCD_3T_37';'FCD_3T_38';...
%     'FCD_3T_40';'FCD_3T_42';'FCD_3T_51';'FCD_3T_55';'FCD_39_recon';};
% ind=find(ismember(subs,Remove));
% subs(ind)=[];
subs={'AlSt';'BeTr'}
% List of features to be normalised
Measures={'.thickness.sm10.mgh'; '.w-g.pct.sm10.mgh';...
    '.pial.K_filtered_2.sm20.mgh';'.gm_FLAIR_0.sm10.mgh';'.gm_FLAIR_0.25.sm10.mgh';'.gm_FLAIR_0.5.sm10.mgh';...
    '.gm_FLAIR_0.75.sm10.mgh';'.wm_FLAIR_0.5.sm10.mgh';'.wm_FLAIR_1.sm10.mgh';};

Measures2={'.pial.K_filtered_2.sm20.mgh'};
NumberOfMeasures=length(Measures);

%subs={'FCD_3T_43'};
for s=1:length(subs);
    
   sub=subs(s)
    %sub=subs(s).name
    sub=cell2mat(sub)
    
  
 
    % Load cortex label for each hemisphere
 Cortexlh=read_label(['',sub,''],['lh.cortex']);
 %Add 1 because freesurfer indexes from 0, and matlab from 1.
 Cortexlh=Cortexlh(:,1)+1;
 Cortexrh=read_label(['',sub,''],['rh.cortex']);
 Cortexrh=Cortexrh(:,1)+1;
 
     %%Load in overlay files for all measures
    %Surf_measures=zeros(1,length(Cortex));
    for L=1:NumberOfMeasures;
        M_lh=MRIread(['',sub,'/surf/lh',Measures{L},'']);
        M_rh=MRIread(['',sub,'/surf/rh',Measures{L},'']); 
   
        % Normalise by mean and std
    M=[M_lh.vol(Cortexlh),M_rh.vol(Cortexrh)];
    meanM=mean(M);
    stdM=std(M);
    M_lh.vol(1,:)=(M_lh.vol(1,:)-meanM)./stdM;
    M_rh.vol(1,:)=(M_rh.vol(1,:)-meanM)./stdM;
    %create string for saving output after removing last 9 characters.
    Meas_output = Measures{L}(1:end-9);
    MRIwrite(M_lh,['',sub,'/surf/lh',Meas_output,'_z.sm10.mgh']);
    MRIwrite(M_rh,['',sub,'/surf/rh',Meas_output,'_z.sm10.mgh']);
    
    end

    
        M_lh=MRIread(['',sub,'/surf/lh',Measures2{1},'']);
        M_rh=MRIread(['',sub,'/surf/rh',Measures2{1},'']); 
   
        % Normalise by mean and std
    M=[M_lh.vol(Cortexlh),M_rh.vol(Cortexrh)];
    meanM=mean(M);
    stdM=std(M);
    M_lh.vol(1,:)=(M_lh.vol(1,:)-meanM)./stdM;
    M_rh.vol(1,:)=(M_rh.vol(1,:)-meanM)./stdM;
    %create string for saving output after removing last 9 characters.
    Meas_output = Measures2{1}(1:end-9);
    MRIwrite(M_lh,['',sub,'/surf/lh',Meas_output,'_z.sm20.mgh']);
    MRIwrite(M_rh,['',sub,'/surf/rh',Meas_output,'_z.sm20.mgh']);
    
    end

 
    