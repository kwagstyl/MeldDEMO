# If you do not have 3D volumetric FLAIR images and want to coregister the FLAIR.nii you have to the reconstructed T1 scans use this script
# ensure you export the FreeSurfer subjects directory

# change path to where subjects are
export SUBJECTS_DIR=~/Desktop/MartinTisdall/sEEG_pnts/Freesurfer/

# list of subjects
sub="BeTr"
#sub="AiOC"
for s in $sub
do 

mri_convert --no_scale 1 "$s"/mri/orig/FLAIR.nii "$s"/mri/orig/FLAIR.mgz
	
bbregister --s "$s" --mov "$s"/mri/orig/FLAIR.mgz --lta "$s"/mri/transforms/FLAIR.lta --init-spm --T2
mri_convert -odt short -at "$s"/mri/transforms/FLAIR.lta -rt cubic -ns 1 -rl "$s"/mri/orig.mgz "$s"/mri/orig/FLAIR.mgz "$s"/mri/FLAIR.prenorm.mgz
cp "$s"/mri/aseg.auto.mgz "$s"/mri/aseg.presurf.mgz
#mri_normalize -sigma 0.5 -nonmax_suppress 0 -min_dist 1 -aseg "$s"/mri/aseg.presurf.mgz -surface "$s"/surf/rh.white identity.nofile -surface "$s"/surf/lh.white identity.nofile "$s"/mri/FLAIR.prenorm.mgz "$s"/mri/FLAIR.mgz

mri_normalize -nonmax_suppress 0 -min_dist 1 -aseg "$s"/mri/aseg.presurf.mgz -surface "$s"/surf/rh.white identity.nofile -surface "$s"/surf/lh.white identity.nofile "$s"/mri/FLAIR.prenorm.mgz "$s"/mri/FLAIR.mgz
done

