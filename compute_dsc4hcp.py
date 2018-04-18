"""Compute DSC"""

from __future__ import print_function
import os
import sys
import argparse
import os.path
import nibabel as nib
import numpy as np
import dipy
from nibabel.streamlines import load
from dipy.tracking.vox2track import streamline_mapping


def compute_dsc4hcp(estimated_tract, true_tract):

    #affine_true=affine_for_trackvis([1.25, 1.25, 1.25])
    aff=np.array([[-1.25, 0, 0, 90],[0, 1.25, 0, -126],[0, 0, 1.25, -72],[0, 0, 0, 1]])

    voxel_list_estimated_tract = streamline_mapping(estimated_tract, affine=aff).keys()
    voxel_list_true_tract = streamline_mapping(true_tract, affine=aff).keys()
    
    TP = len(set(voxel_list_estimated_tract).intersection(set(voxel_list_true_tract)))
    vol_A = len(set(voxel_list_estimated_tract))
    vol_B = len(set(voxel_list_true_tract))
    DSC = 2.0 * float(TP) / float(vol_A + vol_B)

    return DSC, TP, vol_A, vol_B


if __name__ == '__main__':

	parser = argparse.ArgumentParser()
	parser.add_argument('-sub1', nargs='?', const=1, default='',
	                    help='The tract filename of the first subject')
	parser.add_argument('-sub2', nargs='?',  const=1, default='',
	                    help='The tract filename of the second subject')                               
	args = parser.parse_args()

	#Loading tracts
	tract_sub1 = nib.streamlines.load(args.sub1)
	tract_sub1 = tract_sub1.streamlines
	tract_sub2 = nib.streamlines.load(args.sub2)
	tract_sub2 = tract_sub2.streamlines

	DSC, TP, vol_A, vol_B = compute_dsc4hcp(tract_sub1, tract_sub2)
	print("The DSC value between %s and %s is %s" %(args.sub1, args.sub2, DSC))

	#Write DSC on a file
	DSC_results = 'DSC_sub1-sub2.txt'
	with open(DSC_results, "a") as myfile:
            myfile.write("%s\n" %DSC)

	sys.exit()    

