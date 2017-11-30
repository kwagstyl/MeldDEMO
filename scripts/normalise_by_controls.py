#import relevant packages
import numpy as np
import nibabel as nb
import argparse
import io_meld as io

#parse commandline arguments pointing to subject_dir etc
parser = argparse.ArgumentParser(description='normalise by controls mu and std for each vertex')
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

for h in hemis:
    for m in measures:
        control_mu=io.load_mgh('template_control/'+h+'.mu'+m)
        control_std=io.load_mgh('template_control/'+h+'.std'+m)
        for s in subject_ids:
            subject_measure=io.load_mgh(subject_dir+s+'/xhemi/surf/'+h+m)
            z_measure=(subject_measure-control_mu)/control_std)
            io.save_mgh(subject_dir+s+'/xhemi/surf/'+h+'inter_z.'+m,z_measure,demo)


