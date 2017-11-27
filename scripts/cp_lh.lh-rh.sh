
#cd ~/Desktop/Sophie_study/FCD_study_with_FLAIR/FCD_3T/
sub="AlSt BeTr"
for s in $sub
do
cp "$s"/xhemi/surf/lh.lh-rh.pial.K_filtered_2_z.sm20.mgh "$s"/xhemi/surf/rh.lh-rh.pial.K_filtered_2_z.sm20.mgh
cp "$s"/xhemi/surf/lh.lh-rh.thickness_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.thickness_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.w-g.pct_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.w-g.pct_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.LCD_z.mgh "$s"/xhemi/surf/rh.lh-rh.LCD_z.mgh
cp "$s"/xhemi/surf/lh.lh-rh.gm_FLAIR_0_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.gm_FLAIR_0_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.gm_FLAIR_0.25_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.gm_FLAIR_0.25_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.gm_FLAIR_0.5_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.gm_FLAIR_0.5_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.gm_FLAIR_0.75_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.gm_FLAIR_0.75_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.wm_FLAIR_0.5_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.wm_FLAIR_0.5_z.sm10.mgh
cp "$s"/xhemi/surf/lh.lh-rh.wm_FLAIR_1_z.sm10.mgh "$s"/xhemi/surf/rh.lh-rh.wm_FLAIR_1_z.sm10.mgh
done


