# Timescales of spontaneous fMRI fluctuations relate to structural connectivity in the brain

[![DOI](https://zenodo.org/badge/188183937.svg)](https://zenodo.org/badge/latestdoi/188183937)

This repository contains code to reproduce the key figures from Fallon et al.: 'Timescales of spontaneous fMRI fluctuations relate to structural connectivity in the brain'.
[Link to open-access paper in _Network Neuroscience_](https://doi.org/10.1162/netn_a_00151).

## Dependencies

- Some code (for computing timescales) uses `CO_AutoCorrShape` and dependent functions in [_hctsa_](https://github.com/benfulcher/hctsa) ([v1.01](https://github.com/benfulcher/hctsa/releases/tag/v1.01) was used for published results).
- Some functions, `load_nii`, require having tools for reading NIfTI images (e.g., the NIfTI toolbox) installed and in the Matlab path.
-

## Data

Data are available from [zenodo](https://doi.org/10.5281/zenodo.3909007) and should be placed in the `Data` directory as follows:

- Subject info: `Data/subs100.mat`.
    Contains information about all subjects analyzed.
- Structural connectomes: `Data/connectome/`
    Contains structural connectivity data for the three parcellations investigated here.
- Regional time series: `Data/rsfMRI/`.
    Contains a `cfg.mat` file for all subjects.
- Region volumes: `Data/volume/`.
    Contains volume info for all ROIs in each of the three parcellations investigated.
- Results of _hctsa_ analysis: `Data/hctsa_stats.mat`.
- Surface for surface plotting: `Data/fsaverage_surface_data.mat`.

## Analysis code

Add paths to all subdirectories by running `startup`.

### Plots of data for the schematic

Produce data for schematic figure (__Fig. 1__):
```matlab
dataPlotsForSchematic()
```

(Also outputs some surface-space plots used in __Fig. 2D__)

### Relative low-frequency power as a function of node strength (+ partial correction):
Produces __Fig. 2A__:

```matlab
params = GiveMeDefaultParams('DK');
PlotNSScatter(params,'RLFP')
```

This outputs several figures and correlation statistics to the command-line:

| Description | Output |
| ------------- |:-------------:|
| Node strength scatter (correlation and _p_-value in title) | ![](img/PlotNSScatter_4.png) |
| __Fig. 2A__: Residuals from region-volume variation (correlation and _p_-value in title) | ![](img/PlotNSScatter_3.png) |
| Labeling of data points by region ID | ![](img/PlotNSScatter_2.png) |
| Volume scatter | ![](img/PlotNSScatter_1.png) |

These results can be re-run for `'timescale'` or `'fALFF'` instead of `'RLFP'`.

You can also run with different parcellations by modifying the corresponding element of the `params` structure.
For example, to produce Fig. 2C: `params = GiveMeDefaultParams('cust200');`.

### Plot power spectral density curves for selected regions
Produces __Fig. 2B__:

```matlab
PSD_plot()
```

![](img/PSD_plot.png)

### Inter-individual differences in correlations

Produces __Fig. 3__:
```matlab
InterIndividual()
```
![](img/InterIndividual.png)

### Comparison of selected feature to others from _hctsa_

```matlab
hctsaCorr()
```

__Fig 4__:

![](img/hctsaCorr1.png)

Also the raw distribution (without absolute value or taking residuals from volume):

![](img/hctsaCorr2.png)
