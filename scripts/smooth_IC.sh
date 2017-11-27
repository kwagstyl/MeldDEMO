cd ..
sub="AlSt BeTr"
for s in $sub
do
mris_fwhm --s "$s" --hemi lh --cortex --smooth-only --fwhm 20\
 --i "$s"/surf/lh.pial.K_filtered_2.mgh --o "$s"/surf/lh.pial.K_filtered_2.sm20.mgh

mris_fwhm --s "$s" --hemi rh --cortex --smooth-only --fwhm 20\
 --i "$s"/surf/rh.pial.K_filtered_2.mgh --o "$s"/surf/rh.pial.K_filtered_2.sm20.mgh
done

