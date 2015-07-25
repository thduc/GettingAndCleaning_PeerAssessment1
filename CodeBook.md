# Data Set
Full description of the Data Set can be found at [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Variables & transformation

## Step 1:

Training set, training labels, and training subjects are loaded into `trainX`, `trainY`, and `trainSubject`

Similarly test set, test labels, and test subjects are loaded into `testX`, `testY`, and `testSubject`

Train & test data are then combined using `rbind` function to create one data set: `X`, `Y`, and `Subject`

## Step 2:
Features are loaded into variable `features`. The expected indices (mean and standard deviation) are extracted with function `grep`. The indices are then used to remove un-wanted variables. We also assign the proper names for the variables.

## Step 3:
Activities are loaded into variable `activity_labels`. Next `gsub` and `tolower` are used to reformat the activity names. Activity data (`Y`) are convert to descriptive names.

## Step 4:
Name for subject is corrected. Data are then combined with `cbind` function to form a single data set `DataSet`

## Step 5:
`ddply` function from library `plyr` is used to compute the average of each variable for each activity and each subject, results are stored in `AvgData`.
