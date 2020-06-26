# Timescales of spontaneous fMRI fluctuations relate to structural connectivity in the brain

This repository contains code to reproduce the key figures from Fallon et al.: 'Timescales of spontaneous fMRI fluctuations relate to structural connectivity in the brain'.
[_bioRxiv_ preprint is here](https://doi.org/10.1101/655050).

#### Dependencies

Some code (for computing timescales) uses `CO_AutoCorrShape` and dependent functions in _hctsa_ (v1.0.0).

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

### High-frequency power versus weighted degree (with partial correction):
Produces Fig. 2A:

```matlab
corr_lfp_ns
```

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
