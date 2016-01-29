#Getting and Cleaning Data Course Project

Tasks from course page
You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
After downloading zip file need to be unziped and stored in working directory of R (or change working directory)
The zip file contains data collected from the accelerometers (various measured variables) from the Samsung Galaxy S smartphone from 30 experiment volunteers in various activities. 
Further information http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Program description
The following steps are done with run_analysis.R to get clean dataset

1) Read the the test and the train datasets 
2) Read variable names from the original file "features.txt"
3) Clean variable names to be more descriptive
4) Assign variable names to test and train datasets
5) Merge subject, activity and data together for test and train data
6) Extract only the mean and standard deviation for each subject and activity (with reference to variables mean() and std() of features_info.xt)
7) Merge test and train dataset to get one single dataset
8) Read names of activities from "activity_labels.txt" and merge names with the datset
9) Remove duplicate activity column
10) Create clean dataset by aggregating and grouping datset by subject and activity name using mean function 
11) Order clean dataset by subject and activity
12) Save clean dataset as text file
