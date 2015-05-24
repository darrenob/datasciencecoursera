# Course Project for Coursera Course: Getting and Cleaning Data

This project assumes the following data has been extracted into the data/ directory:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Contents
The project contains teh following files
run_analysis.R: merges the train and test data, applies labels then calculates the mean of the variables by activity and subject
codebook.md: information about the variables in the tidy data
README.md: this file

## Operation:
All activity is accries out in the script run_analysis.R which does the following:
1. Merges the training and the test sets to create one data set.
+ This is done mainly using rbind to simply join the data together
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
+ Done using grep to select the nukber indices of any columns containhg "mean" or "std"
3. Uses descriptive activity names to name the activities in the data set
+ the activity names were merged in from the activity_labels.txt file
4. Appropriately labels the data set with descriptive variable names
+ the variable names were read in from features.txt and applied as column names to the merged test & train data set
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
+ The data was melted by activity and subject and then dcast to get the means

The resulting data is displayed on screen and also saved in data/data_means.txt in tabular format.

## Dependencies
The `reshape2` package is required for the run_analysis.R script to work. You can install it like this:
```{r}
install.package("reshape2")
```
