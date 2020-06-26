# Timescales of spontaneous fMRI fluctuations relate to structural connectivity in the brain

This repository contains code to reproduce the key figures from Fallon et al.: 'Timescales of spontaneous fMRI fluctuations relate to structural connectivity in the brain'.
[_bioRxiv_ preprint is here](https://doi.org/10.1101/655050).

#### Dependencies

Some code (for computing timescales) uses `CO_AutoCorrShape` and dependent functions in [_hctsa_](https://github.com/benfulcher/hctsa) ([v1.01](https://github.com/benfulcher/hctsa/releases/tag/v1.01) used for published results).

## Data

* `subs100.mat`: information about all subjects analyzed.
*

## Analysis Code

Add paths to all subdirectories by running `startup`.

### Plots of data for the schematic

Produce data for schematic figure (Fig. 1):
```matlab
dataPlotsForSchematic()
```

### Relative low-frequency power as a function of node strength (+ partial correction):
Produces Fig. 2A:

```matlab
params = GiveMeDefaultParams();
PlotNSScatter(params,'RLFP')
```

This outputs several figures and correlation statistics to commandline:

| Description | Output |
| ------------- |:-------------:|
| Node strength scatter (correlation and _p_-value in title) | ![](img/PlotNSScatter_4.png) |
| Residuals from region-volume variation (correlation and p-value in title) | ![](img/PlotNSScatter_3.png) |
| Labeling of data points by region ID | ![](img/PlotNSScatter_2.png) |
| Volume scatter | ![](img/PlotNSScatter_1.png) |

These results can be re-run for `'timescale'` or `'fALFF'` instead of `'RLFP'`.

### Plot power spectral density curves for selected regions
Produces Fig. 2C:

```matlab
PSD_plot()
```

### Inter-individual differences in correlations
Produces Fig. 3:
```matlab
individual
```

### Comparison of selected feature to other choices from _hctsa_

Produces Fig. 4:

```matlab
hctsa_corr
```
