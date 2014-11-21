coursera.getting.cleaning.data
==============================
 Creation of a set of tidy data from wearable computing data coming from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

there are 3 files in this repository

•README.md -- you are reading it right now

•CodeBook.md -- codebook describing variables, the data and transformations

•run_analysis.R -- actual R code

run_analysis.R objective:
(from coursera assignment)
You should create one R script called run_analysis.R that does the following: 1. Merges the training and the test sets to create one data set. 2. Extracts only the measurements on the mean and standard deviation for each measurement. 3. Uses descriptive activity names to name the activities in the data set 4. Appropriately labels the data set with descriptive activity names. 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The program runs on a folder with the relevant files and folders, so no need to set the working directory on the R script.
The files in user for this R script are:
•activity_labels.txt
•features.txt
•test/
•train/

The output is created in working directory with the name of tidyData.txt

run_analysis.R walkthrough

It follows the goals step by step.
• Step 1:
◦Reads the test and training files: y_test.txt, subject_test.txt and X_test.txt.
◦Combines the files to a data frame in the form of subjects, labels, the rest of the data.

• Step 2:
Reads features from features.txt
Filters to leave features that are either means ("mean()") or standard deviations ("std()"). 
A new data frame is then created that includes subjects, labels and the described features.

• Step 3:
Reads  activity labels from activity_labels.txt
Replaces the numbers with the text.

• Step 4:
Make a column list (includig "subjects" and "label" at the start)
Tidy-fy the list by removing all non-alphanumeric characters and converting the result to lowercase
Apply the now-good-columnnames to the data frame

• Step 5:
Creation of a new data frame. The data frame is created looking for the mean of each combination of subject and label
The function in use is the aggregate()  function

• Final step:
The tidy data set is created with the name tidyData.txt


