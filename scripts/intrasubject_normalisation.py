#import relevant packages
import numpy as np
import nibabel as nb
import argparse
import io_meld as io

#parse commandline arguments pointing to subject_dir etc
parser = argparse.ArgumentParser(description='normalise by across each subject')
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

measures=['.thickness.sm10.mgh', '.w-g.pct.sm10.mgh',
    '.pial.K_filtered_2.sm20.mgh','.gm_FLAIR_0.sm10.mgh','.gm_FLAIR_0.25.sm10.mgh','.gm_FLAIR_0.5.sm10.mgh',
    '.gm_FLAIR_0.75.sm10.mgh','.wm_FLAIR_0.5.sm10.mgh','.wm_FLAIR_1.sm10.mgh']
hemis=['lh','rh']
demo=nb.load(subject_dir+subject_ids[0]+'/xhemi/surf/'+hemis[0]+measures[0])

for h in hemis:
    for s in subject_ids:
        demo=nb.load(subject_dir+s+'/surf/'+h+measures[0])
        cortex=cortex_label=nb.freesurfer.io.read_label(subject_dir + s + '/label/'+h+'.label')
        for m in measures:
            subject_measure=io.load_mgh(subject_dir+s+'/xhemi/surf/'+h+m)
            z_measure=(subject_measure-np.mean(subject_measure[cortex]))/np.std(subject_measure[cortex])
            io.save_mgh(subject_dir+s+'/xhemi/surf/'+h+'intra_z.'+m,z_measure,demo)


