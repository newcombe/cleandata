run_analysis <- function() {
  
  ##First, download the data file and unzip the files.
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, destfile="dataset.zip")
  unzip("dataset.zip")
  
  ## Load libraries
  library(dplyr)
  
  ## 1. Merge the training and test sets to create one data set.
  
  ## First, read each file into a table.
  
  features <- read.table("UCI HAR Dataset/features.txt")
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
  ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
  
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
  ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
  
  ## Bind the data into a single data table
  
  colnames(xtrain) <- features$V2
  colnames(xtest) <- features$V2
  colnames(subject_train) <- "Subject"
  colnames(subject_test) <- "Subject"
  colnames(ytrain) <- "Activity"
  colnames(ytest) <- "Activity"
  colnames(activities) <- c("Activity", "ActivityName")
  
  train <- cbind(xtrain, subject_train, ytrain)
  test <- cbind(xtest, subject_test, ytest)
    
  test_train <- rbind(train, test)
  
  
  ## 2. Extract only the measurements on the mean and standard deviation for each measurement.
  
  extracted_data <- cbind(test_train[, grep("mean", names(test_train), ignore.case=TRUE)], 
                          test_train[, grep("std", names(test_train), ignore.case=TRUE)], 
                          test_train[, 562:563])
  
  ## 3. Use descriptive activity names to name the activities in the data set
 
  extracted_data_activity <- merge(extracted_data, activities, by="Activity")
  
  ## 4. Appropriately labels the data set with descriptive variable names.

  ## This was already completed in Step 1 using colnames() to assign the
  ## names from the features data.
  
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the
  ##    average of each variable for each activity and each subject.
  
  summary_data <- extracted_data_activity %>%
    group_by(Activity, Subject) %>%
    summarise_each(funs(mean))
  
  ## Write the table to .txt file
  
  write.table(summary_data, file="summary_data.txt", row.name=FALSE)
  
}
