# run_analysis
Getting and Cleaning Data Course Project
This repo provides the R script to obtain a tidy data set from the original data available from the following weblink.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The zip file contains ‘test’ and ‘train’ data sets which in turn contain individual text files containing codes for subjects studied (subject-test/train), activities recorded (y-test), and values for parameters measured (features). The relevant codes are available in the activity_labels.txt, features_info.txt, and features.txt files available within the downloaded files.

These individual text files were combined to generate single data frames for the ‘test’ and ‘train’ data sets; specifically only the mean and standard deviation readings for each measurement (feature) were only used. The activity codes were replaced with ‘activity labels’ Then both the ‘test’ and ‘train’ data sets were combined according to activity labels, and subject number; with average readings for each of the features (parameters/variables) measured.

Finally, the tidy data set file (TidyData.csv) was created.

#Part 1
# download and unzip data files

#Part 2
# Load data.table package, load 'activity_labels' and 'features' files as data.table into R, 
# Select only mean and standard deviation for each measurement
# Rename features

#Part 3
# load 'train' and 'test' data files as data.table into R,
# Merge 'train' and 'test' data with activity labels and subject number

#Part 3a
#'train' data files
# load 'train' data files as data.table into R,
# Merge 'train' data with activity labels and subject number

#Part 3b
#'test' data files
# load 'test' data files as data.table into R,
# Merge 'test' data with activity labels and subject number

#Part 4
# merge 'train' and 'test' datasets and add labels
# Convert classLabels to activityName.

#Part 5
# Tidy dataset (TidyData) with average of each variable (feature/parameter)
