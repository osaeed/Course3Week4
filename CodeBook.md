Week 4 for Assignment for Omer Saeed

Study Design:
This assignment utilizes a dataset of accelerometer data from Samsung Galaxy S smartphones for
various activities such as walking and standing.  The dataset is described at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and the raw data utilized is at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The assignment requires us to generate 2 tidy datasets
1.  A dataset containing the activity type and all mean and std columns from both the train and test datasets
2.  A dataset with the means of all columns in the first data set, summarized by the activity type

Code Book:
The following R Version was utilized
platform       x86_64-apple-darwin13.4.0   
arch           x86_64                      
os             darwin13.4.0                
system         x86_64, darwin13.4.0        
status                                     
major          3                           
minor          2.1                         
year           2015                        
month          06                          
day            18                          
svn rev        68531                       
language       R                           
version.string R version 3.2.1 (2015-06-18)
nickname       World-Famous Astronaut      


The following libraries are required for the script.  They should be 
data.table (utilized version ‘1.12.2’)
dplyr (utilized version ‘0.8.1’)

The following raw data files from the zip are utilized in this assignment
features.txt - contains all the data collected for each observation in the dataset.  Essentially, the column names
activity_labels.txt - contains the mappings of activity numbers to the textual descriptions (e.g. Walking)
train/X_train.txt - the observed accelerometer data in the train group
train/subject_train.txt - the person/subject for each observation row in X_train.txt
train/y_train.txt - the activity type for each observation row in X_train.txt
test/X_test.txt - the observed accelerometer data in the test group  
test/subject_test.txt - the person/subject for each observaction row in X_test.txt
test/y_test.txt - the activity type for each observaction row in X_test.txt

The following script was utilized to process the raw data and generate the tidy datasets
run_analysis.R

The working directory fo run_analysis.R needs to be the root directory of the raw data (that contains features.txt, 
activity_labels.txt, and the subdirectories train and test)

The following variables were utilized in run_analysis.R
features - data table containing the raw data from features.txt
activityLabels - data table containing the raw data from activity_labels.txt
testActivities - data table containing the raw data from test/y_test.txt
testObs - data table containing the raw data from test/X_test.txt.  Later appended with testActivities and testSubjects
testSubjects - data table containing the raw data from test/subject_test.txt
trainActivities - data table containing the raw data from train/y_train.txt
trainObs - data table containing the raw data from train/X_train.txt.  Later appended with trainActivities and trainSubjects
trainSubjects - data table containing the raw data from train/subject_train.txt
allObs - data table containing the combined data from testObs and trainObs (all rows), including columns for activityNumber and subjectNumber
obsIndexes - a numeric vector containing the column numbers of the required data for the first tidy dataset
partialObs - a data table containing a subset of columns of allObs defined by obsIndexes
partialObsWithActivityLabel - a data table consisting of partialObs with activityName mapped in from activityLabels, based on activityNumber.
							This is also the first required tidy dataset.
summaryPartialObsGroupBy - a data table consisting of partialObsWithActivityLabel with group by applied to activityName and subjectNumber
summaryPartialObs - a data table consisting of a summaryPartialObsGroupBy summarized by activityName and subjectNumber, with mean applied to all other columns.
							This is also the second required tidy dataset.
							

Comments within run_analysis.R give further details on the logic and steps to generate the tidy data.
							
The script outputs 2 tidy datasets to the working directory
1.  step4.txt - an export of partialObsWithActivityLabel, the dataset requested in step 4 of the assignment.  
This dataset contains the activity type and all mean and std columns from both the train and test datasets.

2.  step5.txt - an export of summaryPartialObs, the dataset requested in step 5 of the assignment.  
This dataset contains the means of all columns in the first data set, summarized by the activity type.


