########################### SCRIPT 2 ###################################################

##This script needs to be run on all patients and all controls
## Change to your subjects directory ##
SUBJECT_DIR=$1
subject_list=$2

cd "$SUBJECT_DIR"
export SUBJECTS_DIR="$SUBJECT_DIR"


## Import list of subjects
subjects=$(<"$subject_list")
# for each subject do the following
for s in $subjects
do
  surfreg --s "$s" --t fsaverage_sym --lh
  surfreg --s "$s" --t fsaverage_sym --lh --xhemi
done

