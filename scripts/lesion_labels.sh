
# Move lesion Label
# Move onto left hemisphere
#mris_apply_reg --src  "$s"/surf/lh.lesion_3.mgh --trg "$s"/xhemi/surf/lh.lesion_on_lh.mgh  --streg $SUBJECTS_DIR/"$s"/surf/lh.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg
#mris_apply_reg --src "$s"/surf/rh.lesion_3.mgh --trg "$s"/xhemi/surf/rh.lesion_on_lh.mgh   --streg $SUBJECTS_DIR/"$s"/xhemi/surf/lh.fsaverage_sym.sphere.reg     $SUBJECTS_DIR/fsaverage_sym/surf/lh.sphere.reg


