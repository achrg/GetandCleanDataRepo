Getting and Cleaning Data Project

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

The R code run_analysis.R allows one to do the following. 

    1. Merge the training and the test sets to create one data set.
    2. Extract only the measurements on the mean and standard deviation for each measurement. 
    3. Use descriptive activity names to name the activities in the data set
    4. Appropriately label the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each             activity and each subject.

What you find in this repository is the following:

    1. CodeBook.md
    2. README.md
    3. run_analysis.R
    
Steps to follow to tidy up the following data folder: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

  1. Clone this repository
  2. Set the current working directory to yours
  3. run the whole run_analysis.R (the code will download the data automatically so you won't need to do it)
  4. the output tidy datasets will be named tidydata.txt and tidydataAverage.txt
  




