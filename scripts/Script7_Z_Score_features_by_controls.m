%% Script 7. Intersubject normalisation of features - Z-score by controls
clear all

%% Z score patient measures by controls
% Directory of patients
SUBJECTS_DIR = '~/Desktop/MartinTisdall/sEEG_pnts/Freesurfer'
cd(SUBJECTS_DIR)

setenv SUBJECTS_DIR .
addpath /Applications/freesurfer/matlab/

%change to appropriate prefix
subs={'AlSt';'BeTr'}

% Load cortex label. +1 for freesurfer matlab indexing
Cortex=read_label(['fsaverage_sym'],['lh.cortex']);
 Cortex=Cortex(:,1)+1;  

 Measures={'.thickness_z_on_lh.sm10.mgh'; '.asym.thickness_z.sm10.mgh';...
    '.w-g.pct_z_on_lh.sm10.mgh';'.asym.w-g.pct_z.sm10.mgh';...
    '.CurvatureDisc_z_on_lh.mgh';'.asym.CurvatureDisc_z.mgh';...
        '.curv_on_lh.mgh';'.sulc_on_lh.mgh';...
    '.gm_FLAIR_0.75_z_on_lh.sm10.mgh';'.gm_FLAIR_0.5_z_on_lh.sm10.mgh';...
    '.gm_FLAIR_0.25_z_on_lh.sm10.mgh';'.gm_FLAIR_0_z_on_lh.sm10.mgh';...
    '.wm_FLAIR_0.5_z_on_lh.sm10.mgh';'.wm_FLAIR_1_z_on_lh.sm10.mgh';...
    '.asym.gm_FLAIR_0.75_z.sm10.mgh';'.asym.gm_FLAIR_0.5_z.sm10.mgh';...
    '.asym.gm_FLAIR_0.25_z.sm10.mgh';'.asym.gm_FLAIR_0_z.sm10.mgh';...
    '.asym.wm_FLAIR_0.5_z.sm10.mgh';'.asym.wm_FLAIR_1_z.sm10.mgh'};
 
Measures2={'.thickness_z_on_lh.sm10.mgh'; '.asym.thickness_z.sm10.mgh';...
    '.w-g.pct_z_on_lh.sm10.mgh';'.asym.w-g.pct_z.sm10.mgh';...
    '.pial.K_filtered_2_z_on_lh.sm20.mgh';'.asym.pial.K_filtered_2_z.sm20.mgh';...
        '.curv_on_lh.mgh';'.sulc_on_lh.mgh';...
    '.gm_FLAIR_0.75_z_on_lh.sm10.mgh';'.gm_FLAIR_0.5_z_on_lh.sm10.mgh';...
    '.gm_FLAIR_0.25_z_on_lh.sm10.mgh';'.gm_FLAIR_0_z_on_lh.sm10.mgh';...
    '.wm_FLAIR_0.5_z_on_lh.sm10.mgh';'.wm_FLAIR_1_z_on_lh.sm10.mgh';...
    '.asym.gm_FLAIR_0.75_z.sm10.mgh';'.asym.gm_FLAIR_0.5_z.sm10.mgh';...
    '.asym.gm_FLAIR_0.25_z.sm10.mgh';'.asym.gm_FLAIR_0_z.sm10.mgh';...
    '.asym.wm_FLAIR_0.5_z.sm10.mgh';'.asym.wm_FLAIR_1_z.sm10.mgh'};

%Measures2={'.pial.K_filtered_2_z_on_lh.sm20.mgh';'.asym.pial.K_filtered_2_z.sm20.mgh';};
% Directory of controls
%change to appropriate control directory and prefix
Control_dir= '/Users/sophie/Desktop/Sophie_study/FCD_study_with_FLAIR/HC_3T/'
cd(Control_dir)
Cons=dir('C_*');
cons=cell(length(Cons),1);

    

% For each measure normalise by controls    
    for L = 1:length(Measures2);
  
Normal_C_L=zeros(length(cons),length(Cortex));
Normal_C_R=zeros(length(cons),length(Cortex)); 
     
cd(Control_dir)
setenv SUBJECTS_DIR .
for c = 1:length(Cons);
    con=Cons(c).name;
  
 % Load measure in controls and extract cortical values
    ML_C=MRIread(['',con,'/xhemi/surf/lh',Measures2{L},'']);
    Normal_C_L(c,:)=ML_C.vol(Cortex);
        MR_C=MRIread(['',con,'/xhemi/surf/rh',Measures2{L},'']);
   Normal_C_R(c,:)=MR_C.vol(Cortex);
end

% Change to patient directory
cd(SUBJECTS_DIR)
setenv SUBJECTS_DIR .
Measure_L=zeros(length(subs),length(Cortex));
Measure_R=zeros(length(subs),length(Cortex));


for s = 1:length(subs)
 sub=subs(s);
 
    sub=cell2mat(sub);   

    %Load patient data measure for each hemisphere
        ML=MRIread(['',sub,'/xhemi/surf/lh',Measures2{L},'']);
    Measure_L(s,:)=ML.vol(Cortex);
    
    MR=MRIread(['',sub,'/xhemi/surf/rh',Measures2{L},'']);
    Measure_R(s,:)=MR.vol(Cortex);

end

% Normalise left hemi by controls by mean and std
zMeasure_L = zeros(size(Measure_L));
meanY=nanmean(Normal_C_L,1);
stdY=nanstd(Normal_C_L, 0, 1);
for i = 1 : size(Measure_L,1)
    zMeasure_L(i, :) = (Measure_L(i,:) - meanY)./stdY;
end
% Normalise  right hemi by controls
zMeasure_R = zeros(size(Measure_R));
meanY=nanmean(Normal_C_R,1);
stdY=nanstd(Normal_C_R, 0, 1);
for i = 1 : size(Measure_R,1)
    zMeasure_R(i, :) = (Measure_R(i,:) - meanY)./stdY;
end

for t=1:length(subs);
   sub=subs(t);
 
    sub=cell2mat(sub);    
Dummy=MRIread(['',sub,'/xhemi/surf/lh.thickness_z_on_lh.sm10.mgh']);
  Dummy.vol(:)=0;
  
  Dummy.vol(Cortex)=zMeasure_L(t,:);
  % Change to patient directory
cd(SUBJECTS_DIR)
MRIwrite(Dummy,['',sub,'/xhemi/surf/lh.Z_by_controls',Measures2{L},''])
  
  

  
   Dummy.vol(Cortex)=zMeasure_R(t,:);
  
  MRIwrite(Dummy,['',sub,'/xhemi/surf/rh.Z_by_controls',Measures2{L},''])
end 

 
end



    
