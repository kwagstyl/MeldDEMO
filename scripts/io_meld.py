import numpy as np
import nibabel as nb

def import_mgh(filename):
    """ import mgh file using nibabel. returns flattened data array"""
    mgh_file=nb.load(filename)
    mmap_data=mgh_file.get_data()
    array_data=np.ndarray.flatten(mmap_data)
    return array_data;

def save_mgh(filename,array, demo):
    """ save mgh file using nibabel and imported demo mgh file"""
    mmap=np.memmap('/tmp/tmp', dtype='float32', mode='w+', shape=demo.get_data().shape)
    mmap[:,0,0]=array[:]
    output=nb.MGHImage(mmap, demo.affine, demo.header)
    nb.save(output, filename)

def load_subject_features(fs_id,features,subject_number,cortex_label):
    hemis=['lh','rh']
    h_index=-1
    feature_matrix = [] 
    for h in hemis:
        h_index+=1
        hemisphere_feature_matrix = []
        for f in features:
            feature = np.array(nb.load(subjects_dir + fs_id + '/xhemi/surf/'+h+f).get_data()).ravel()
            #set medial wall values to zero
            feature[medial_wall]=0
            hemisphere_feature_matrix.append(feature)
        #vertex
        hemisphere_feature_matrix.append(np.arange(len(feature),dtype='float32'))
        #hemisphere
        hemisphere_feature_matrix.append(np.ones(len(feature),dtype='float32')*h_index)
        #subject_id
        hemisphere_feature_matrix.append(np.ones(len(feature),dtype='float32')*subject_number)
        #lesion
        lesion_label = subjects_dir + fs_id + '/xhemi/surf/'+h+'.lesion_on_lh.mgh'
        #check if lesion is on this hemisphere (1 is lesion, 0 is not)
        if os.path.isfile(lesion_label):
            lesion = np.round(np.array(nb.load(lesion_label).get_data(),dtype='float32').ravel())
            hemisphere_feature_matrix.append(lesion)
            #otherwise only zeros
        else :
            hemisphere_feature_matrix.append(np.zeros(len(feature),dtype='float32'))
        hemisphere_feature_matrix = np.transpose(np.array(hemisphere_feature_matrix))
        feature_matrix.extend(hemisphere_feature_matrix)
    return feature_matrix
