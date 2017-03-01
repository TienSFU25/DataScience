# You should create one R script called run_analysis.R that does the following.

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# reads the data in
destDir <- "./data/uciHarDataset/"
testDir <- "test/"
trainDir <- "train/"
idMapDir <- "subject_test.txt"
featuresDir <- "X_test.txt"
activitiesDir <- "y_test.txt"
trainIdMapDir <- "subject_train.txt"
trainFeaturesDir <- "X_train.txt"
trainActivitiesDir <- "y_train.txt"

# read in the files
if (FALSE) {
  testIdMap <- tbl_df(read.table(paste0(destDir, testDir, idMapDir)))
  testFeatures <- tbl_df(read.table(paste0(destDir, testDir, featuresDir)))
  testActivities <- tbl_df(read.table(paste0(destDir, testDir, activitiesDir)))
  trainIdMap <- tbl_df(read.table(paste0(destDir, trainDir, trainIdMapDir)))
  trainFeatures <- tbl_df(read.table(paste0(destDir, trainDir, trainFeaturesDir)))
  trainActivities <- tbl_df(read.table(paste0(destDir, trainDir, trainActivitiesDir)))
}

# convert activity IDs into labels
activityLabels <- tbl_df(read.table(paste0(destDir, "activity_labels.txt"), stringsAsFactors = FALSE))
testActivitiesAsLabels <- transmute(testActivities, activity=activityLabels[as.numeric(V1), 2][[1]])
trainActivitiesAsLabels <- transmute(trainActivities, activity=activityLabels[as.numeric(V1), 2][[1]])

# get only features' means and stds
allFeatures <- tbl_df(read.table(paste0(destDir, "features.txt"), stringsAsFactors = FALSE))
features <- filter(allFeatures, grepl("^.*(-mean\\(\\)|-std\\(\\))", V2))
featureIndexes <- features[[1]]
featureNames <- features[[2]]

# select feature columns from the test table
testData <- testFeatures %>%
  select(featureIndexes)

# stick on the Activity and Subject columns
testData <- cbind(testData, testActivitiesAsLabels, testIdMap)
colnames(testData) <- c(featureNames, "Activity", "Subject")

# to know where this data came from when we later merge with training data
testData <- testData %>% mutate(ExperimentType="test")

# do the exact same 3 steps above with training data
trainData <- trainFeatures %>%
  select(featureIndexes)
trainData <- cbind(trainData, trainActivitiesAsLabels, trainIdMap)
colnames(trainData) <- c(featureNames, "Activity", "Subject")
trainData <- trainData %>% mutate(ExperimentType="train")

# combine the test and training data
mergedData <- rbind(testData, trainData) %>% arrange(Subject)

# compute the average by activity and subject
# difficult to do in dplyr, so we will use data.table
# groups by Activity, Subject and computes the mean from all (feature) columns
mergedDataAsTable <- setDT(mergedData)
summary <- mergedDataAsTable[, lapply(.SD, mean), by=.(Activity, Subject, ExperimentType), .SDcols=`tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`]

# optional. Writes the summary to a file
# write.csv(summary, "./summary.csv")