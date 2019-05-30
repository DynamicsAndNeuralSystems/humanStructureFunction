# Human structure-function rs-fMRI

## Reproducing the main analyses

### Plots of data for the schematic

Produces data for schematic figure:
```matlab
dataPlotsForSchematic
```

### High-frequency power versus weighted degree (with partial correction):
Produces Figure 1A:

```matlab
corr_lfp_ns
```

### Plot power spectral density curves for selected regions

```matlab
PSD_plot
```

### Inter-individual differences in correlations

```matlab
individual
```

### Comparison of selected feature to other choices from _hctsa_

```matlab
hctsa_corr
```

## Where to get data
#### FUNCTIONAL
`/kg98/john/data/functional/{SUB_ID}-cfg.mat`

#### STRUCTURAL
`/kg98/john/data/structural/conn_data_100.mat`

#### 4 different connectomes
`SIFT2_density`, `SIFT2_connectome`, `standard_density`, `standard_connectome`.

#### REGION VOLUME
`/kg98/john/data/volume/{SUB_ID}.nii.gz`

#### T1
`/kg98/john/data/t1t2/T1T2_mean_roi_values.mat`
