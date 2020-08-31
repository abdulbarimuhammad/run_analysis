#Part 1
# download and unzip data files

path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "Humanactivity.zip"))
Humanactivitydata <- unzip("Humanactivity.zip")

#Part 2
# Load data.table package, load 'activity_labels' and 'features' files as data.table into R, 
# Select only mean and standard deviation for each measurement
# Rename features

library(data.table)
activityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), 
						col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), 
						col.names = c("index", "featureNames"))
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)


#Part 3
# load 'train' and 'test' data files as data.table into R,
# Merge 'train' and 'test' data with activity labels and subject number

#Part 3a
#'train' data files
# load 'train' data files as data.table into R,
# Merge 'train' data with activity labels and subject number

train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]

data.table::setnames(train, colnames(train), measurements)

trainActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")

, col.names = c("Activity"))

trainSubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")

, col.names = c("SubjectNum"))

train <- cbind(trainSubjects, trainActivities, train)

#Part 3b
#'test' data files
# load 'test' data files as data.table into R,
# Merge 'test' data with activity labels and subject number

test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]

data.table::setnames(test, colnames(test), measurements)

testActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")

, col.names = c("Activity"))

testSubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")

, col.names = c("SubjectNum"))

test <- cbind(testSubjects, testActivities, test)


#Part 4
# merge 'train' and 'test' datasets and add labels

combined <- rbind(train, test)


# Convert classLabels to activityName.

combined[["Activity"]] <- factor(combined[, Activity]

, levels = activityLabels[["classLabels"]]

, labels = activityLabels[["activityName"]])

combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])

#Part 5
# Tidy dataset (TidyData) with average of each variable
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))

combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined, file = "tidyData.csv", quote = FALSE)