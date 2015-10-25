setwd("~/Desktop/Coursera")

## For each record in the dataset it is provided:
## - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
## - Triaxial Angular velocity from the gyroscope.
## - A 561-feature vector with time and frequency domain variables.
## - Its activity label.
## - An identifier of the subject who carried out the experiment. 

## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. CFrom the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Loading libraries

if (!require(reshape2)) {install.packages('reshape2')}
require(reshape2)

if (!require(plyr)) {install.packages('plyr')}
require(plyr)

# Downloading Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="Data.zip",method="curl")

# Unzipping downloaded file
unzip(zipfile="Data.zip")

##########
# 1. Merges the training and the test sets to create one data set 
##########

# Loading subject information
subjectData_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subjectData_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Loading training data
activityData_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
featureData_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Loading test data
activityData_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
featureData_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

# Combines data tables
activityData <- rbind(activityData_train, activityData_test)
featureData <- rbind(featureData_train, featureData_test)
subjectData<-rbind(subjectData_train, subjectData_test)

# Renaming columns
names(subjectData) <- "subject_ID"
names(featureData) <- "activity_ID"

# Loading features labels & rename columns in activityData
featureNames <- read.table("UCI HAR Dataset/features.txt", header = FALSE)[,2]
names(activityData) <- featureNames

# Merging activityData, featureData and subjectData to get the final dataset

combined1 <- cbind(subjectData, featureData)
final_data <- cbind(combined1, activityData)

str(final_data)

##########
## 2. Extracts only the measurements on the mean and standard deviation for each measurement
##########
features2Keep <- featureNames[grep("mean\\(\\)|std\\(\\)", featureNames)]
columns2Keep<-c("subject_ID", "activity_ID", as.character(features2Keep))

data<-subset(final_data,select=columns2Keep)
str(data)

## 3. Uses descriptive activity names to name the activities in the data set

# Loading activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activityLabels) <- c("activity_ID","activity_Description")

data_<-merge(data,activityLabels)
data_<-subset(data_,select=c("subject_ID","activity_Description",as.character(features2Keep)))

##########
## 4. Appropriately labels the data set with descriptive activity names
##########

names(data_)<-gsub("Acc", "Accelerometer", names(data_))
names(data_)<-gsub("BodyBody", "Body", names(data_))
names(data_)<-gsub("Gyro", "Gyroscope", names(data_))
names(data_)<-gsub("Mag", "Magnitude", names(data_))

names(data_)<-gsub("^t", "Time", names(data_))
names(data_)<-gsub("^f", "Frequency", names(data_))

names(data_)
write.table(data_, file = "tidydata.txt",row.name=FALSE)

##########
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########

dataAverage_<-aggregate(. ~subject_ID + activity_Description, data_,mean)
write.table(dataAverage_, file = "tidydataAverage.txt",row.name=FALSE)

