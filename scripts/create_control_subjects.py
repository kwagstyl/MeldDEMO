# create control subjects to carry out z-scores
import numpy as np
import nibabel as nb
import argparse

#subjects dir
parser = argparse.ArgumentParser(description='create mu and std overlays from a set of subjects to carry out z-scoring.')
parser.add_argument('subject_dir', type=str, 
                    help='path to subject dir')
parser.add_argument('subject_ids', 
                    type=str,
                    help='textfile containing list of subject ids')

args = parser.parse_args()

#list of subjects
subject_dir=args.subject_dir
subject_ids_filename=args.subject_ids
subject_ids=np.loadtxt(subject_dir+subject_ids_filename, dtype='str')

def import_mgh(filename):
    """ import mgh file using nibabel. returns flattened data array"""
    mgh_file=nb.load(filename)
    mmap_data=mgh_file.get_data()
    array_data=np.ndarray.flatten(mmap_data)
    return array_data;
    
    
measures=np.array(['.thickness_z_on_lh.sm10.mgh', '.asym.thickness_z.sm10.mgh',
    '.w-g.pct_z_on_lh.sm10.mgh','.asym.w-g.pct_z.sm10.mgh',
    '.pial.K_filtered_2_z_on_lh.sm20.mgh','.asym.pial.K_filtered_2_z.sm20.mgh',
        '.curv_on_lh.mgh','.sulc_on_lh.mgh',
    '.gm_FLAIR_0.75_z_on_lh.sm10.mgh','.gm_FLAIR_0.5_z_on_lh.sm10.mgh',
    '.gm_FLAIR_0.25_z_on_lh.sm10.mgh','.gm_FLAIR_0_z_on_lh.sm10.mgh',
    '.wm_FLAIR_0.5_z_on_lh.sm10.mgh','.wm_FLAIR_1_z_on_lh.sm10.mgh',
    '.asym.gm_FLAIR_0.75_z.sm10.mgh','.asym.gm_FLAIR_0.5_z.sm10.mgh',
    '.asym.gm_FLAIR_0.25_z.sm10.mgh','.asym.gm_FLAIR_0_z.sm10.mgh',
'.asym.wm_FLAIR_0.5_z.sm10.mgh','.asym.wm_FLAIR_1_z.sm10.mgh'])
