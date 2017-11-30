#import relevant packages
import numpy as np
import nibabel as nb
import argparse
import io_meld as io

#parse commandline arguments pointing to subject_dir etc
parser = argparse.ArgumentParser(description='create feature matrix for all subjects')
parser.add_argument('subject_dir', type=str,
                    help='path to subject dir')
parser.add_argument('subject_ids',
                    type=str,
                    help='textfile containing list of subject ids')
parser.add_argument('output',
                    type=str,
                    help='output filename')

args = parser.parse_args()


#save subjects dir and subject ids. import the text file containing subject ids
subject_dir=args.subject_dir
subject_ids_filename=args.subject_ids
subject_ids=np.loadtxt(subject_dir+subject_ids_filename, dtype='str')
output=args.output

#list features
features = np.array(['.Z_by_controls.thickness_z_on_lh.sm10.mgh', '.Z_by_controls.lh-rh.thickness_z.sm10.mgh',
    '.Z_by_controls.w-g.pct_z_on_lh.sm10.mgh','.Z_by_controls.lh-rh.w-g.pct_z.sm10.mgh',
    '.Z_by_controls.curv_on_lh.mgh','.Z_by_controls.sulc_on_lh.mgh',
    '.Z_by_controls.gm_FLAIR_0.75_z_on_lh.sm10.mgh','.Z_by_controls.gm_FLAIR_0.5_z_on_lh.sm10.mgh',
    '.Z_by_controls.gm_FLAIR_0.25_z_on_lh.sm10.mgh','.Z_by_controls.gm_FLAIR_0_z_on_lh.sm10.mgh',
    '.Z_by_controls.wm_FLAIR_0.5_z_on_lh.sm10.mgh','.Z_by_controls.wm_FLAIR_1_z_on_lh.sm10.mgh',
    '.Z_by_controls.lh-rh.gm_FLAIR_0.75_z.sm10.mgh','.Z_by_controls.lh-rh.gm_FLAIR_0.5_z.sm10.mgh',
    '.Z_by_controls.lh-rh.gm_FLAIR_0.25_z.sm10.mgh','.Z_by_controls.lh-rh.gm_FLAIR_0_z.sm10.mgh',
    '.Z_by_controls.lh-rh.wm_FLAIR_0.5_z.sm10.mgh','.Z_by_controls.lh-rh.wm_FLAIR_1_z.sm10.mgh',
    '.Z_by_controls.lh-rh.pial.K_filtered_2_z.sm20.mgh','.Z_by_controls.pial.K_filtered_2_z_on_lh.sm20.mgh'])

cortex_label=np.sort(io.load_mesh_data(subjects_dir + 'fsaverage_sym/label/lh.cortex.label'))
medial_wall = np.delete(np.arange(163842),cortex_label)


k=-1
all_subjects_data = []
for subject in subject_ids:
    k+=1
    subject_data = load_subject_features(subject, features, k,medial_wall)
    all_subjects_data.extend(subject_data)
    
all_subjects_data=np.array(all_subjects_data)


np.save(output,all_subjects_data)

