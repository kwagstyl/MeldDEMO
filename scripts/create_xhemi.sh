
#cd ~/Desktop/Sophie_study/FCD_study_with_FLAIR/FCD_3T/
#sub="35 36 37 38 40 41 42 43 44 45 46 47 48 49 50 52 53 54"
#sub="FCD_3T_36 FCD_3T_44 FCD_3T_45 FCD_3T_46 FCD_3T_47 FCD_3T_49 FCD_3T_51"
#sub="FCD_3T_31 FCD_3T_35 FCD_3T_41 FCD_3T_48 FCD_3T_50 FCD_3T_53 FCD_3T_56 FCD_3T_57 FCD_3T_54"

sub="BeTr"
for s in $sub
do
  surfreg --s "$s" --t fsaverage_sym --lh
  surfreg --s "$s" --t fsaverage_sym --lh --xhemi
done

