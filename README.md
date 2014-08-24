README -- Human Activity Recognition Using Smartphones Analysis
========================================================

The analysis functions are contained within a single script file, run_analysis.R.

To run the analysis, download the source data zip file.  The file should be unzipped to a sub-folder of the script file named, "UCI HAR Dataset".

Run the script by executing:
```{r}
run_analysis()
```

or to capture the output to a variable
```{r}
results <- run_analysis()
```

A file named subjectActivityMeans.txt with the analysis results will be output to the current folder.