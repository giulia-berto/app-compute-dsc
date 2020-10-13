[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.212-blue.svg)](https://doi.org/10.25663/brainlife.app.212)

# app-compute-dsc
This App was designed to compute the degree of overlap between two bundle masks using the Dice Similarity Coefficient (DSC) score (Dice et al., 1945). The DSC is a standard score to evaluate the result of bundle segmentation, being the two bundle masks (i) the estimated mask and (ii) the ground truth mask (see for example Garyfallidis et al., 2017, Wasserthal et al., 2018, Bertò et al., 2020).  
Given two bundles b̂ and b, the DSC is proportional to the number of common voxels over the total number of voxels, as follows:

<img src="https://latex.codecogs.com/gif.latex?DSC=2\cdot(|v(\hat{b})\cap&space;v(b)|)/(|v(\hat{b})|&plus;|v(b)|)" title="DSC=2\cdot(|v(\hat{b})\cap v(b)|)/(|v(\hat{b})|+|v(b)|)" />

where |v()| is the number of voxels of the bundle mask. The DSC ranges from 0 to 1 and the closer the score is to 1, the more the two bundles are similar.

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

### Running the App
### On [Brainlife.io](http://brainlife.io/) 
You can submit this App online at https://doi.org/10.25663/brainlife.app.212 via the “Execute” tab.

Inputs: \
The two inputs are (i) a collection of estimated masks and (ii) a collection of ground truth masks. If you have bundles in WMC format, you can convert them in the correct datatype by using this App: https://doi.org/10.25663/brainlife.app.142. WARNING: be sure that the two collections contain the exact same bundles, and that are in the same anatomical space.

Output: \
Along with the DSC score, other 5 common scores are returned, specifically: \
* [Dice Similarity Coefficient](https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient) (DSC) 
* [Jaccard index](https://en.wikipedia.org/wiki/Jaccard_index) (J) 
* [sensitivity](https://en.wikipedia.org/wiki/Sensitivity_and_specificity)
* [True Positives](https://en.wikipedia.org/wiki/False_positives_and_false_negatives) (TP) 
* [False Positives](https://en.wikipedia.org/wiki/False_positives_and_false_negatives) (FP)
* [False Negatives](https://en.wikipedia.org/wiki/False_positives_and_false_negatives) (FN)

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
        "seg_est": "./input/estimated_tracts/masks",
	"seg_true": "./input/true_tracts/masks"
}
```

3. Launch the App by executing `main`

```bash
./main
```

### Output
The main output of this App is a file called `output_FiberStats.csv`, in which on the columns there are the different scores, and on the rows the different bundles of the collections.

### Dependencies
This App only requires [singularity](https://sylabs.io/singularity/) to run. 

#### MIT Copyright (c) 2020 Bruno Kessler Foundation (FBK)
