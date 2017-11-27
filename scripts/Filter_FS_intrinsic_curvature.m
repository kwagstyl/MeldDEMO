clear all
%change to appropriate subjects_dir
SUBJECTS_DIR = '~/Desktop/MartinTisdall/sEEG_pnts/Freesurfer'
cd(SUBJECTS_DIR)

%setting up environment and libraries
setenv SUBJECTS_DIR .
addpath /Applications/freesurfer/matlab/

%get list of subjects (here all subjects begin with FCD_)
% Subs=dir('FCD_*');
% subs=cell(length(Subs),1);
% for s = 1:length(Subs);
%     subs{s}=Subs(s).name;
% end
% Remove={'FCD_3T_1'; 'FCD_3T_4';'FCD_3T_8';'FCD_3T_12';'FCD_3T_18';'FCD_3T_22';...
%     'FCD_3T_28';'FCD_3T_32';'FCD_3T_34';'FCD_3T_35';'FCD_3T_37';'FCD_3T_38';'FCD_39_recon';...
%     'FCD_3T_40';'FCD_3T_42';'FCD_3T_51';'FCD_3T_55'};
%     
%Remove={'FCD_05_recon'; 'FCD_14_recon';'FCD_15_recon';'FCD_16_recon';'FCD_23_recon';'FCD_31_recon';'FCD_43_recon';'FCD_44_recon';...
 %   'FCD_42_recon';'FCD_35_recon';'FCD_45_recon';'FCD_30_recon'};

 
% ind=find(ismember(subs,Remove));
% subs(ind)=[];
subs={'AlSt';'BeTr'}
for s=1:length(subs)
    clear IC
    sub=subs(s);
    sub=cell2mat(sub);
  
 % Load in intrinsic curvature 
    IC = MRIread(['',sub,'/surf/lh.pial.K.mgh']);
    IC.vol(IC.vol>2)=0;
    IC.vol(IC.vol>-2)=0;
    MRIwrite(IC,['',sub,'/surf/lh.pial.K_filtered_2.mgh']);
    
    IC_white = read_curv(['',sub,'/surf/lh.white.K.crv']);
    IC_white(IC_white>2)=0;
    IC_white(IC_white>-2)=0;
    IC.vol=IC_white';
    MRIwrite(IC,['',sub,'/surf/lh.white.K_filtered_2.mgh']);
    
    clear IC
    IC = MRIread(['',sub,'/surf/rh.pial.K.mgh']);
    IC.vol(IC.vol>2)=0;
    IC.vol(IC.vol>-2)=0;
    MRIwrite(IC,['',sub,'/surf/rh.pial.K_filtered_2.mgh']);    
    
    IC_white = read_curv(['',sub,'/surf/rh.white.K.crv']);
    IC_white(IC_white>2)=0;
    IC_white(IC_white>-2)=0;
    IC.vol=IC_white';
    MRIwrite(IC,['',sub,'/surf/rh.white.K_filtered_2.mgh']);
end    