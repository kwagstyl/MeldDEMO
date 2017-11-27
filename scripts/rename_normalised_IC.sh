cd ..
s="AlSt BeTr"
for s in $sub
do
mv "$s"/surf/lh.pial.K_filtered_2_z.sm10.mgh "$s"/surf/lh.pial.K_filtered_2_z.sm20.mgh
mv "$s"/surf/rh.pial.K_filtered_2_z.sm10.mgh "$s"/surf/rh.pial.K_filtered_2_z.sm20.mgh
done
