 Human Activity Recognition Using Smartphones Analysis
========================================================

The dataset is generated from this source data:  [UCI Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

An analysis, encoded in run_analysis.R, was performed on this data whereby the source training and test datasets are combined into a single dataset.  The combined dataset is then reshaped to produce mean values of each standard deviation and mean value variable for each test subject and each physical activity that was observed.  The resultant dataset is written to a file named subjectActivityMeans.txt.

## Analysis Process
The analysis script performs the following activities:

1.  Combines the measurement data from the source training and test datasets.
2.  Adds names to the measurement variables in the combined dataset.
3.  Subsets the data to include only mean and standard deviation variables.
4.  Merges the "Y values" to the dataset.  These are the activities being performed by the subject when each measurement is taken.
5.  Merges the subject identifier to each measurement.
6.  The merged data is then used to compute the mean of each variable by subject and activity.
7.  The mean values for each variable by subject and activity are output to a text file, subjectActivityMeans.txt

## Running the Analysis Script
The script assumes that the input data is unzipped to a sub-folder of the script location named, "UCI HAR Dataset".  The output data file is written to the current folder.

Run the script by executing:
```{r}
run_analysis()
```

or to capture the output to a variable
```{r}
results <- run_analysis()
```

## Dataset Attributes
The output dataset is a text file that has these attributes:

| Attribute     | Description    | 
| --------|---------|
| Subject  | Identifier of the test subject   | 
| Activity | Activity being performed by the subject at time of measurement | 
| Variable | The name of the variable being measured  | 
| Mean | The mean value of the variable from all measurements for this subject and activity | 



