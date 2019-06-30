"""Compute the following voxel measures:
DSC, wDSC, J, sensitivity, TP, FP, FN.
"""

import sys
import argparse
import nibabel as nib
import numpy as np
from dipy.tracking.vox2track import streamline_mapping


def compute_voxel_measures(estimated_tract, true_tract, aff):

    #aff=np.array([[-1.25, 0, 0, 90],[0, 1.25, 0, -126],[0, 0, 1.25, -72],[0, 0, 0, 1]])
    voxel_list_estimated_tract = streamline_mapping(estimated_tract, affine=aff).keys()
    voxel_list_true_tract = streamline_mapping(true_tract, affine=aff).keys()

    n_ET = len(estimated_tract)
    n_TT = len(true_tract)	
    dictionary_ET = streamline_mapping(estimated_tract, affine=aff)
    dictionary_TT = streamline_mapping(true_tract, affine=aff)
    voxel_list_intersection = set(voxel_list_estimated_tract).intersection(set(voxel_list_true_tract))

    if n_ET==0:
    	return 0, 0, 0, 0, 0, len(set(voxel_list_true_tract))

    sum_int_ET = 0
    sum_int_TT = 0
    for k in voxel_list_intersection:
	sum_int_ET = sum_int_ET + len(dictionary_ET[k])
	sum_int_TT = sum_int_TT + len(dictionary_TT[k])
    sum_int_ET = sum_int_ET/n_ET
    sum_int_TT = sum_int_TT/n_TT

    sum_ET = 0
    for k in voxel_list_estimated_tract:
	sum_ET = sum_ET + len(dictionary_ET[k])
    sum_ET = sum_ET/n_ET

    sum_TT = 0
    for k in voxel_list_true_tract:
	sum_TT = sum_TT + len(dictionary_TT[k])
    sum_TT = sum_TT/n_TT
    
    TP = len(set(voxel_list_estimated_tract).intersection(set(voxel_list_true_tract)))
    vol_A = len(set(voxel_list_estimated_tract))
    vol_B = len(set(voxel_list_true_tract))
    FP = vol_B-TP
    FN = vol_A-TP
    sensitivity = float(TP) / float(TP + FN) 
    DSC = 2.0 * float(TP) / float(vol_A + vol_B)
    wDSC = float(sum_int_ET + sum_int_TT) / float(sum_ET + sum_TT)
    J = float(TP) / float(TP + FN + FP)

    return DSC, wDSC, J, sensitivity, TP, FP, FN


if __name__ == '__main__':

	parser = argparse.ArgumentParser()
	parser.add_argument('-sub', nargs='?', const=1, default='',
	                    help='Subject ID')
	parser.add_argument('-dir_est', nargs='?',  const=1, default='',
	                    help='Directory of estimated tracts')  
	parser.add_argument('-dir_true', nargs='?',  const=1, default='',
	                    help='Directory of ground truth tracts')                        
	args = parser.parse_args()

	#Write results on a file
	results = 'sub-%s_results.csv' %args.sub
	metrics = ['DSC', 'wDSC', 'J', 'sens', 'TP', 'FP', 'FN']
	with open(results, 'a') as csvFile:
		writer = csv.writer(csvFile)
		writer.writerow(metrics)

	with open('tract_name_list.txt') as f:
		tract_name_list = f.read().splitlines()

	results_matrix = np.zeros((len(tract_name_list), len(metrics)))
	
	for t, tract_name in enumerate(tract_name_list):
		estimated_tract_filename = '%s/%s_tract.trk' %(args.dir_est, tract_name)
		estimated_tract = nib.streamlines.load(estimated_tract_filename)
		estimated_tract = estimated_tract.streamlines
		true_tract_filename = '%s/%s_tract.trk' %(args.dir_true, tract_name)
		true_tract = nib.streamlines.load(true_tract_filename)
		affine = true_tract.affine
		print(affine)
		true_tract = true_tract.streamlines
		DSC, wDSC, J, sensitivity, TP, FP, FN = compute_voxel_measures(estimated_tract, true_tract, affine)
		print("The DSC of the tract %s is %s" %(tract_name, DSC))
		results_matrix[t] = [DSC, wDSC, J, sensitivity, TP, FP, FN] 
		with open(results, "a") as csvFile:
			writer = csv.writer(csvFile)
			writer.writerow(np.float16(results_matrix[t]))
	
	np.save('%s_results' %args.sub, results_matrix)
	sys.exit()    
