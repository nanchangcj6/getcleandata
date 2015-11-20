#Project Description
The Getting and Cleaning data course project instructs students to: 

Create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Collection of raw data
The raw source data files are found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The files contained within the zip file are described in the *README.txt* file found in the root directory of the zip file.

##Creating tidy file
The process of creating the tidy dataset is described in the *README.md* markdown file in this github repo.

The resulting dataset meets the course instructions as well as the definition of a tidy dataset being:

* Each variable in its own column
* Each observation forming its own row
* Each type of observational unit forms a table
* The first row contains human-readable variable names

##Description of variables in tidy file
The resulting tidy file is called *final tidy submission.txt* and comprises 40 observations of 68 columns.  The file looks as follows:

subject_id | activity_name | tBodyAcc-mean-X | tBodyAcc-mean-Y | (and 64 other columns)
--- | --- | --- | --- | ---
1 | STANDING | 0.265696921 | -0.018298173 | ..
2 | STANDING | 0.273113116 | -0.019132318 | ..
3 | STANDING | 0.27342872 | -0.017856067 | ..

Where:

Column | Description
------ | -----------
subject_id (int) | The unique id associated with the person carrying out the test activites in the range 1-30.
activity_name (factor) | The name of the test activity from a range of "WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "LAYING", "SITTING", "STANDING"
measurement_id (num) | 66 unique measurement variables, either a mean or standard deviation measurement, extracted from the raw data and presented as the average of each variable for each activity name and each subject id.

The 66 measurement_id columns above are more fully described in the *README.txt* file in the source data zip file and summarised below: 

The measures in the raw source datasets come from the accelerometer and gyroscope 3-axial raw signals in the X, Y, and Z dimensions (tAcc-XYZ and tGyro-XYZ).  These sensors generally measure in units of metres per second or number of "g" (accelerometer) or degrees per second (gyroscope), but in this experiment, the units have been enhanced as follows.  

The time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (prefix 'f' to denote frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern where 'X,Y or Z' is used to denote 3-axial signals in the X, Y and Z directions.

Note that the tidy data only contains the mean and standard deviation of these measurements resulting in variable names as follows

tBodyAcc-mean-X  
tBodyAcc-mean-Y  
tBodyAcc-mean-Z  
tGravityAcc-mean-X  
tGravityAcc-mean-Y  
tGravityAcc-mean-Z  
tBodyAccJerk-mean-X  
tBodyAccJerk-mean-Y  
tBodyAccJerk-mean-Z  
tBodyGyro-mean-X  
tBodyGyro-mean-Y  
tBodyGyro-mean-Z  
tBodyGyroJerk-mean-X  
tBodyGyroJerk-mean-Y  
tBodyGyroJerk-mean-Z  
tBodyAccMag-mean  
tGravityAccMag-mean  
tBodyAccJerkMag-mean  
tBodyGyroMag-mean  
tBodyGyroJerkMag-mean  
fBodyAcc-mean-X  
fBodyAcc-mean-Y  
fBodyAcc-mean-Z  
fBodyAccJerk-mean-X  
fBodyAccJerk-mean-Y  
fBodyAccJerk-mean-Z  
fBodyGyro-mean-X  
fBodyGyro-mean-Y  
fBodyGyro-mean-Z  
fBodyAccMag-mean  
fBodyBodyAccJerkMag-mean  
fBodyBodyGyroMag-mean  
fBodyBodyGyroJerkMag-mean  
tBodyAcc-std-X  
tBodyAcc-std-Y  
tBodyAcc-std-Z  
tGravityAcc-std-X  
tGravityAcc-std-Y  
tGravityAcc-std-Z  
tBodyAccJerk-std-X  
tBodyAccJerk-std-Y  
tBodyAccJerk-std-Z  
tBodyGyro-std-X  
tBodyGyro-std-Y  
tBodyGyro-std-Z  
tBodyGyroJerk-std-X  
tBodyGyroJerk-std-Y  
tBodyGyroJerk-std-Z  
tBodyAccMag-std  
tGravityAccMag-std  
tBodyAccJerkMag-std  
tBodyGyroMag-std  
tBodyGyroJerkMag-std  
fBodyAcc-std-X  
fBodyAcc-std-Y  
fBodyAcc-std-Z  
fBodyAccJerk-std-X  
fBodyAccJerk-std-Y  
fBodyAccJerk-std-Z  
fBodyGyro-std-X  
fBodyGyro-std-Y  
fBodyGyro-std-Z  
fBodyAccMag-std  
fBodyBodyAccJerkMag-std  
fBodyBodyGyroMag-std  
fBodyBodyGyroJerkMag-std  

