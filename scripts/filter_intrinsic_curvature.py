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

hemis=['lh','rh']

for h in hemis:
    for s in subject_ids:
        demo = nb.load(subject_dir+s+'/surf/' + h + '.pial.K.mgh')
        curvature=io.load_mgh(subject_dir+s+'/surf/' + h + '.pial.K.mgh')
        curvature[curvature>-2]=0
        io.save_mgh(subject_dir+s+'/surf/'+h+'.pial.K_filtered_2.mgh',curvature,demo)


