# create control subjects to carry out z-scores
#import relevant packages
import numpy as np
import nibabel as nb
import argparse


#parse commandline arguments pointing to subject_dir etc
parser = argparse.ArgumentParser(description='create mu and std overlays from a set of subjects to carry out z-scoring.')
parser.add_argument('subject_dir', type=str, 
                    help='path to subject dir')
parser.add_argument('subject_ids', 
                    type=str,
                    help='textfile containing list of subject ids')

args = parser.parse_args()

#save subjects dir and subject ids. import the text file containing subject ids
subject_dir=args.subject_dir
subject_ids_filename=args.subject_ids
subject_ids=np.loadtxt(subject_dir+subject_ids_filename, dtype='str')

def import_mgh(filename):
    """ import mgh file using nibabel. returns flattened data array"""
    mgh_file=nb.load(filename)
    mmap_data=mgh_file.get_data()
    array_data=np.ndarray.flatten(mmap_data)
    return array_data;

def save_mgh(filename,array, demo):
   """ save mgh file using nibabel and imported demo mgh file"""
    mmap=np.memmap('/tmp/tmp', dtype='float32', mode='w+', shape=demo.get_data().shape)
    mmap_data_filtered[:,0,0]=array[:]
    output=nb.MGHImage(mmap_data_filtered, demo.affine, demo.header)
    nb.save(output, filename)

measures=['.thickness_z_on_lh.sm10.mgh', '.asym.thickness_z.sm10.mgh',
    '.w-g.pct_z_on_lh.sm10.mgh','.asym.w-g.pct_z.sm10.mgh',
    '.pial.K_filtered_2_z_on_lh.sm20.mgh','.asym.pial.K_filtered_2_z.sm20.mgh',
        '.curv_on_lh.mgh','.sulc_on_lh.mgh',
    '.gm_FLAIR_0.75_z_on_lh.sm10.mgh','.gm_FLAIR_0.5_z_on_lh.sm10.mgh',
    '.gm_FLAIR_0.25_z_on_lh.sm10.mgh','.gm_FLAIR_0_z_on_lh.sm10.mgh',
    '.wm_FLAIR_0.5_z_on_lh.sm10.mgh','.wm_FLAIR_1_z_on_lh.sm10.mgh',
    '.asym.gm_FLAIR_0.75_z.sm10.mgh','.asym.gm_FLAIR_0.5_z.sm10.mgh',
    '.asym.gm_FLAIR_0.25_z.sm10.mgh','.asym.gm_FLAIR_0_z.sm10.mgh',
'.asym.wm_FLAIR_0.5_z.sm10.mgh','.asym.wm_FLAIR_1_z.sm10.mgh']

hemis=['lh','rh']


demo=nb.load(subject_dir+subject_ids[0]+'/xhemi/surf/'+hemis[0]+measures[0])
#cortex=nb.freesurfer.io.read_label(subject_dir+subject_ids[0]+'/xhemi/label/lh.cortrex')

for h in hemis:
    for m in measures:
        control_data=np.zeros(len(subject_ids),len(demo.get_data()))
        k=-1
        for s in subject_ids:
            k+=1
            control_data[k]=import_mgh(subject_dir+s+'/xhemi/surf/'+h+m)
        mean=np.mean(control_data,axis=1)
        std=np.std(control_data,axis=1)
        save_mgh(subject_dir+'template_control/'+h+'.mu'+m,mean,demo)
        save_mgh(subject_dir+'template_control/'+h+'.std'+m,mean,demo)

