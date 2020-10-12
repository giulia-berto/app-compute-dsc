[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.346-blue.svg)](https://doi.org/10.25663/brainlife.app.57)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.346-blue.svg)](https://doi.org/10.25663/brainlife.app.211)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.346-blue.svg)](https://doi.org/10.25663/brainlife.app.212)

# app-compute-dsc
This App was designed to compute the degree of overlap, at the voxel level, between an estimated bundle and a ground truth bundle. A standard score to measure such degree of overlap is the Dice Similarity Coefficient (DSC) score (Dice et al, 1945). If the bundles are given in form of streamlines, first, the corresponding voxel masks are retrieved, and then the DSC is computed by counting the number of voxels in common and the total number of voxels, as follows:

<img src="https://latex.codecogs.com/gif.latex?DSC=2\cdot(|v(\hat{b})\cap&space;v(b)|)/(|v(\hat{b})|&plus;|v(b)|)" title="DSC=2\cdot(|v(\hat{b})\cap v(b)|)/(|v(\hat{b})|+|v(b)|)" />

where b̂ and b are the two bundles and |v()| is the number of voxels of the voxel mask. The DSC ranges from 0 to 1 and the closer the score is to 1, the more the two bundles are similar.
