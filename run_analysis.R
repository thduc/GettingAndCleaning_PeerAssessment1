library(plyr)

# 1. Merges the training and the test sets to create one data set.
dataPath <- "~/Downloads/UCI HAR Dataset"

trainSubject <- read.table(paste(dataPath, "/train/subject_train.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)
trainX <- read.table(paste(dataPath, "/train/X_train.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)
trainY <- read.table(paste(dataPath, "/train/y_train.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)

testSubject <- read.table(paste(dataPath, "/test/subject_test.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)
testX <- read.table(paste(dataPath, "/test/X_test.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)
testY <- read.table(paste(dataPath, "/test/y_test.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)

Subject <- rbind(trainSubject, testSubject)
X <- rbind(trainX, testX)
Y <- rbind(trainY, testY)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table(paste(dataPath, "/features.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)
extracted_features_indices <- grep("-(mean|std)\\(\\)", features[, 2])

X <- X[, extracted_features_indices]
names(X) <- features[extracted_features_indices, 2]

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table(paste(dataPath, "/activity_labels.txt", sep = ""), header = FALSE, stringsAsFactors = FALSE)
activity_labels[, 2] = gsub("_", "", tolower(activity_labels[, 2]))
Y[,1] = activity_labels[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names.
names(Subject) <- "subject"

DataSet <- cbind(X, Y, Subject)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

AvgData <- ddply(DataSet, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(AvgData, paste(dataPath, "/averages_data.txt", sep = ""), row.name=FALSE)
