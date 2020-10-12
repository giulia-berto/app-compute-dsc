[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.346-blue.svg)](https://doi.org/10.25663/brainlife.app.57)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.346-blue.svg)](https://doi.org/10.25663/brainlife.app.211)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.346-blue.svg)](https://doi.org/10.25663/brainlife.app.212)

# app-compute-dsc
This App was designed to compute the degree of overlap, at the voxel level, between an estimated bundle and a ground truth bundle. A standard score to measure such degree of overlap is the Dice Similarity Coefficient (DSC) score (Dice et al, 1945). If the bundles are given in form of streamlines, first, the corresponding voxel masks are retrieved, and then the DSC is computed by counting the number of voxels in common and the total number of voxels, as follows:

<img src="https://latex.codecogs.com/gif.latex?DSC=2\cdot(|v(\hat{b})\cap&space;v(b)|)/(|v(\hat{b})|&plus;|v(b)|)" title="DSC=2\cdot(|v(\hat{b})\cap v(b)|)/(|v(\hat{b})|+|v(b)|)" />

where b̂ and b are the two bundles and |v()| is the number of voxels of the voxel mask. The DSC ranges from 0 to 1 and the closer the score is to 1, the more the two bundles are similar.

### Authors
- [Giulia Bertò](giulia.berto.4@gmail.com)

### Contributors
- [Emanuele Olivetti](olivetti@fbk.eu)

### Funding Acknowledgement
brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations
We kindly ask that you cite the following articles when publishing papers and code using this code. 

1. Dice, L. R., 1945. Measures of the amount of ecologic association between species. Ecology 26 (3), 297–302. [https://www.jstor.org/stable/1932409](https://www.jstor.org/stable/1932409)

2. Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [https://doi.org/10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Running the App 

### On Brainlife.io
Depending on the kind of input data, there are three different Apps that you can run:
* DSC evaluation (wmc - wmc) 
* DSC evaluation (wmc - trk)
* DSC evaluation (mask - mask)

You can submit this App online at [https://doi.org/10.25663/bl.app.1](https://doi.org/10.25663/bl.app.1) via the "Execute" tab.

