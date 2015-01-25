# Read Me:  cleandata Repo
Course project for "Getting and Cleaning" data course

This repo contains the following files:
1. run_analysis.R
2. codebook.md

## 1. run_analysis.R
Contains a script to download the gyroscope dataset, create a tidy data
set, and generate a summary table table of means grouped by subject and
activity.  The script accomplishes the following tasks:
* Download the data file and unzip the files.
* Load libraries
* Merge the training and test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Use descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Write the table to .txt file called "summary_data.txt"

## 2. codebook.md
This file contains the codebook for the dataset.
