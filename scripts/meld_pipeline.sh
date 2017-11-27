########### master script for running the meld pipeline. this script assumes freesurfer QC and lesion masks have already been created ########


##run script through controls ##

subjects_dir= "$basedir"controls/
subject_ids="$subjects_dir"control_ids.txt

if [ ! -f "$subject_ids" ]; then
    echo "No controls found. Normalisation steps will be by demo controls"
    controls="False"
else
    echo "Controls found, Running control scripts..."
#create basic features
    bash Script1_sample_FLAIR_smooth_features.sh "$subjects_dir" "$subject_ids"
#normalise intrasubject
    python intrasubject_normalisation.py "$subjects_dir" "$subject_ids"
#register to fsaverage xhemi
    bash create_xhemi.sh "$subjects_dir" "$subject_ids"
    bash Script_move_to_xhemi.sh "$subjects_dir" "$subject_ids"
#create the mu and std overlays for subsequent normalisation of controls and patients
    python create_control_subjects.py "$subjects_dir" "$subject_ids" 
#normalise controls by mu and std
    python normalise_by_controls.py "$subjects_dir" "$subject_ids"
#create training_data matrix
    python create_training_data.py "$subjects_dir" "$subject_ids" meld_centre_prefix_controls
fi


subjects_dir="$basedir"patients/
subject_ids="$subjects_dir"fcd_ids.txt

if [ ! -f "$subject_ids" ]; then
    echo "No fcd positive ids found. skipping creating fcd_positive tables"
else
    echo "FCD patients found, Running feature scripts..."
#create basic features
    bash Script1_sample_FLAIR_smooth_features.sh "$subjects_dir" "$subject_ids"
#normalise intrasubject
    python intrasubject_normalisation.py "$subjects_dir" "$subject_ids"
#register to fsaverage xhemi
    bash create_xhemi.sh "$subjects_dir" "$subject_ids"
    bash Script_move_to_xhemi.sh "$subjects_dir" "$subject_ids"
#normalise patients by mu and std
    python normalise_by_controls.py "$subjects_dir" "$subject_ids" 
#move lesion labels across
    bash move_lesion_labels.sh "$subjects_dir" "$subject_ids"
#create training_data matrix
    python create_training_data.py "$subjects_dir" "$subject_ids" meld_centre_prefix_fcd
fi

subject_ids="$subjects_dir"negs_ids.txt

if [ ! -f "$subject_ids" ]; then
    echo "No lesion negative ids found. skipping creating lesion_negatives tables"
else
    echo "FCD patients found, Running feature scripts..."
#create basic features
    bash Script1_sample_FLAIR_smooth_features.sh "$subjects_dir" "$subject_ids"
#normalise intrasubject
    python intrasubject_normalisation.py "$subjects_dir" "$subject_ids"
#register to fsaverage xhemi
    bash create_xhemi.sh "$subjects_dir" "$subject_ids"
    bash Script_move_to_xhemi.sh "$subjects_dir" "$subject_ids"
#normalise patients by mu and std
    python normalise_by_controls.py "$subjects_dir" "$subject_ids"
#create training_data matrix
    python create_training_data.py "$subjects_dir" "$subject_ids" meld_centre_prefix_negs
fi



