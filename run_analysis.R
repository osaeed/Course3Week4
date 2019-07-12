# This script assumes that the working directory is the root of the UCI HAR Dataset unzipped,
# meaning that it is the directory that contains features.txt, activity_labels.txt, and the subdirectories 
# for test and train

# use the data.table library as well as dplyr
library(data.table)
library(dplyr)

# Read in the features, which is a description of the columns, and the activity_labels, which map the activity
# numbers to an activity name
features <- fread("features.txt", sep = " ", header = FALSE, col.names = c("featureNumber", "featureName"))
activityLabels <- fread("activity_labels.txt", sep = " ", col.names = c("activityNumber", "activityName"))

# Read in the activities and observations from the test directory.  Append the activities as the first column
# of the observations data frame.  While reading the observations, set the column names to the features loaded
# earlier. Also ignore any 
# duplicate column name warnings as they relate to columns we do not care about for further analysis.
testActivities <- fread("test/y_test.txt", sep = " ", col.names = c("activityNumber"))
testObs <- fread("test/X_test.txt", col.names = features$featureName, sep = " ")
testObs <- cbind(testActivities, testObs)
testSubjects <- fread("test/subject_test.txt", sep = " ", col.names = c("subjectNumber"))
testObs <- cbind(testSubjects, testObs)

# Repeat with the activities and observations from the train directory.
trainActivities <- fread("train/y_train.txt", sep = " ", col.names = c("activityNumber"))
trainObs <- fread("train/X_train.txt", col.names = features$featureName, sep = " ")
trainObs <- cbind(trainActivities, trainObs)
trainSubjects <- fread("train/subject_train.txt", sep = " ", col.names = c("subjectNumber"))
trainObs <- cbind(trainSubjects, trainObs)


# Combine the test and train observations into a single dataset
allObs <- rbind(testObs, trainObs)

# Create a data table with only the columns subjectNumber, activityNumber, any mean() observations, and any std() 
# observations. First create a vector of column names subjectNumber, activityNumber, mean(), and std(), 
# then subset the columns into a new data table named partialObs
obsIndexes <- grep("subjectNumber|activityNumber|mean\\(\\)|std\\(\\)", names(allObs))
partialObs <- allObs[,..obsIndexes]

# now merge in the activiyName based on the activityNumber.  First set the key columns on the tables
# we are going to join, then perform the merge
setkey(partialObs, activityNumber)
setkey(activityLabels, activityNumber)
partialObsWithActivityLabel <- merge(partialObs, activityLabels)

# reorder the columns of the data table so that activityName is the first column.  Drop the activityNumber column
setcolorder(partialObsWithActivityLabel, neworder=c(2, 69,1, 3:68))
partialObsWithActivityLabel[,activityNumber:=NULL]

# Export the tidy table to a new text file (Step 4 of assignment)
write.table(partialObsWithActivityLabel, file="step4.txt", row.names=FALSE, col.names=TRUE, sep = " ", quote=FALSE)

# Get the means for each column by activityName and subjectNumber.  
# summaryPartialObs is the final tidy table for Step 5 of the assignment.
# First set the group by on the data table, then summarize.  
summaryPartialObsGroupBy <- group_by(partialObsWithActivityLabel, activityName, subjectNumber)
summaryPartialObs <- summarize_all(summaryPartialObsGroupBy, mean)

# Export the tidy table to a new text file (Step 5 of the assignment)
write.table(summaryPartialObs, file="step5.txt", row.names=FALSE, col.names=TRUE, sep = " ", quote=FALSE)