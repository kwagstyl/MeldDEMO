###################### SCRIPT 6#######################
# This script Moves features to fsaverage_sym - a bilaterally symmetrical template
# Then it calculates interhemsipheric asymmetry
# It also moves the manual lesion label to fsaverage_sym
##Run on all patients and controls

## Change to your subjects directory ##
subject_dir=$1
subject_list=$2

cd "$subejct_dir"
export SUBJECTS_DIR="$subject_dir"



## Import list of subjects
subjects=$(<"$subject_list")

Measures="thickness w-g.pct gm_FLAIR_0 gm_FLAIR_0.25 gm_FLAIR_0.5 gm_FLAIR_0.75 wm_FLAIR_0.5 wm_FLAIR_1 "
#
Measures2="pial.K_filtered_2_z"
#These measures are done separately as they are not smoothed or z scored.
Measures3="curv sulc"

for s in $subjects
do
  #create one all zero overlay for inversion step
  cp "$s"/surf/lh."$m"_z.sm10.mgh "$s"/xhemi/surf/zeros.mgh
  mris_calc --output "$s"/xhemi/surf/zeros.mgh set 0

  for m in $Measures
  do

    # Move onto left hemisphere
    mris_apply_reg --src  "$s"/surf/lh."$m"_z.sm10.mgh --trg "$s"/xhemi/surf/lh."$m"_z_on_lh.sm10.mgh  --streg $SUBJECTS_DIR/"$s"/surf/lh.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
    mris_apply_reg --src "$s"/surf/rh."$m"_z.sm10.mgh --trg "$s"/xhemi/surf/rh."$m"_z_on_lh.sm10.mgh    --streg $SUBJECTS_DIR/"$s"/xhemi/surf/lh.fsaverage_sym.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
    # Calculate interhemispheric asymmetry
    mris_calc --output "$s"/xhemi/surf/lh.lh-rh."$m"_z.sm10.mgh "$s"/xhemi/surf/lh."$m"_z_on_lh.sm10.mgh sub "$s"/xhemi/surf/rh."$m"_z_on_lh.sm10.mgh
    # invert interhemisphereic asymmetry
    mris_calc --output "$s"/xhemi/surf/rh.lh-rh."$m"_z.sm10.mgh "$s"/xhemi/surf/zeros.mgh sub "$s"/xhemi/surf/lh.lh-rh."$m"_z.sm10.mgh
  done

  for m2 in $Measures2
  do

    # Move onto left hemisphere
    mris_apply_reg --src  "$s"/surf/lh."$m"_z.sm20.mgh --trg "$s"/xhemi/surf/lh."$m"_z_on_lh.sm20.mgh  --streg $SUBJECTS_DIR/"$s"/surf/lh.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
    mris_apply_reg --src "$s"/surf/rh."$m"_z.sm20.mgh --trg "$s"/xhemi/surf/rh."$m"_z_on_lh.sm20.mgh    --streg $SUBJECTS_DIR/"$s"/xhemi/surf/lh.fsaverage_sym $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
    # Calculate interhemispheric asymmetry
    mris_calc --output "$s"/xhemi/surf/lh.lh-rh."$m"_z.sm20.mgh "$s"/xhemi/surf/lh."$m"_z_on_lh.sm20.mgh sub "$s"/xhemi/surf/rh."$m"_z_on_lh.sm20.mgh
    # invert interhemisphereic asymmetry
    mris_calc --output "$s"/xhemi/surf/rh.lh-rh."$m"_z.sm20.mgh "$s"/xhemi/surf/zeros.mgh sub "$s"/xhemi/surf/lh.lh-rh."$m"_z.sm20.mgh
  done

  for m3 in $Measures3
  do

    # Move onto left hemisphere
    mris_apply_reg --src  "$s"/surf/lh."$m3".mgh --trg "$s"/xhemi/surf/lh."$m3"_on_lh.mgh  --streg $SUBJECTS_DIR/"$s"/surf/lh.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
    mris_apply_reg --src "$s"/surf/rh."$m3".mgh --trg "$s"/xhemi/surf/rh."$m3"_on_lh.mgh    --streg $SUBJECTS_DIR/"$s"/xhemi/surf/lh.fsaverage_sym.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
    # Asymmetry
    mris_calc --output "$s"/xhemi/surf/lh.lh-rh."$m3".mgh "$s"/xhemi/surf/lh."$m3"_on_lh.mgh sub "$s"/xhemi/surf/rh."$m3"_on_lh.mgh
    mris_calc --output "$s"/xhemi/surf/rh.lh-rh."$m3".mgh "$s"/xhemi/surf/zeros.mgh sub "$s"/xhemi/surf/lh.lh-rh."$m3".mgh

  done

done
