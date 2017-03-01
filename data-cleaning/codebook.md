# Code Book

This document describes the code in `run_analysis.R`

The script assumes the UCI Har dataset folder is already downloaded at the directory `./data/uciHarDataset/`

## Code structure

The script is functional and linear, applying incremental transforms in each step to get to the "result"

1. Read in the files
2. Parse the `activity_labels.txt` file to get a mapping from activity ID to a string

3. Convert the `y_test.txt` and `y_train.txt` tables with the activity labels above
 ![alt text](https://raw.githubusercontent.com/TienSFU25/DataScience/master/data-cleaning/images/testActLabels.PNG "Test Activity Labels")
 ![alt text](https://raw.githubusercontent.com/TienSFU25/DataScience/master/data-cleaning/images/trainActLabels.PNG "Training Activity Labels")
4. Parse the `features.txt` file and select only "mean" and "std" columns. This results in two vectors: featureIndexes and featureNames
 ![alt text](https://raw.githubusercontent.com/TienSFU25/DataScience/master/data-cleaning/images/featureIndexes.PNG "Feature Indexes")
 ![alt text](https://raw.githubusercontent.com/TienSFU25/DataScience/master/data-cleaning/images/featureNames.PNG "Feature Names")

5. For the test data
 * Select only the features in `X.test` that are in the feature vector of step 4
 * Column bind the activityLabels of step 3 and subjectId of step 1 into two columns: "Activity" and "Subject"
 * Add an additional column "Type" with the value `test`. This will be helpful when we later merge with training data

6. Do step 5 with training data, except "Type" has the value `train`
7. Merge test and training data

Dimensions of the variables created in steps 5-7: `testData`, `trainData` and `mergedData`

![alt text](https://raw.githubusercontent.com/TienSFU25/DataScience/master/data-cleaning/images/dims.PNG "Dimensions of the 3 variables in steps 5-7")

8. Compute the mean of each feature by `Activity` and `Subject`. Write this to `summary.csv`