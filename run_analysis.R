#  Getting and Cleaning Data Course Project 

#  You should create one R script called run_analysis.R that does the following. 
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.

#  dplyr will be used in stages two and three 
library(dplyr)

#  Stage One: Merge the training and test datasets to create one data set

#  Start with the "test" set of datasets

#  Set up dataset name variables

#  dataset of the test subjects (i.e. persons) doing the tests
subject <- "../UCI HAR Dataset/test/subject_test.txt"

#  test results in 561 columns of measurement results
X_test <- "../UCI HAR Dataset/test/X_test.txt"

#  the id of the test the person was doing range 1:6  
y_test <- "../UCI HAR Dataset/test/y_test.txt"

#  names of the actual tests such as Walking, Standing, etc. with the key as 
#  indicated in the file above
activity_names <- "../UCI HAR Dataset/activity_labels.txt"

#  names of the measurements - these become the column names for the test 
#  results in "X_test" above
features <- "../UCI HAR Dataset/features.txt"

#  Read the activities into a data frame and give it columns names
actdf <- read.table(activity_names, 
                header=FALSE, 
                sep=" ", 
                col.names=(c("activity_id", "activity_name")))

#  read the ids of the tests
y_testdf <- read.table(y_test, 
                header=FALSE, 
                col.names = c("activity_id"))

#  and merge these two data frames based on the commmon id being careful to avoid
#  changing the order (sort=FALSE)
mergedf <- merge(y_testdf, actdf, 
                by.x="activity_id", by.y="activity_id", 
                all=TRUE, 
                sort=FALSE)

#  now read the subject id (i.e. person id) and give it a column name
subdf <- read.table(subject, 
                header=FALSE, 
                col.names=("subject_id"))

#  and cbind this as a new column to the merged data frame created above
fulldf <- cbind(subdf, mergedf)

#  Now read the big results table
testvardf <- read.table(X_test, 
                header=FALSE, 
                strip.white = TRUE)

#  and read the column header names
featdf <- read.table(features, 
                header=FALSE, 
                col.names=c("id", "feature"))

#  Now remove the open/close parenthesis "()" at the end of most of the 
#  feature names to make column headings more human friendly
featdf <- as.data.frame(sapply(featdf, 
                               gsub, 
                               pattern="\\()", 
                               replacement=""))

#  extract the column names and name the columns in the data frame
name <- featdf[, "feature"]
colnames(testvardf) = name

#  and finally cbind this with the id and activity_name data frame
test_finaldf <- cbind(fulldf, testvardf)

#  clean up memory
rm(list=c("actdf", 
          "y_testdf", 
          "mergedf", 
          "subdf", 
          "fulldf", 
          "testvardf", 
          "featdf", 
          "name"))

#  Now repeat for the "train" files

#  dataset of the test subjects (i.e. persons) doing the tests
subject <- "../UCI HAR Dataset/train/subject_train.txt"

#  train results in 561 columns
X_train <- "../UCI HAR Dataset/train/X_train.txt"

#  range 1:6 corresponding to the id of the test the person was doing
y_train <- "../UCI HAR Dataset/train/y_train.txt"

#  names of the actual tests such as Walking, Standing, etc. with the key as above
activity_names <- "../UCI HAR Dataset/activity_labels.txt"

#  names of the sensors - become the column names for the train results 
#  in "X_train" above
features <- "../UCI HAR Dataset/features.txt"

#  Read the activities into a data frame and give it columns names
actdf <- read.table(activity_names, 
                header=FALSE, 
                sep=" ", 
                col.names=(c("activity_id", "activity_name")))

#  read the ids of the the tests
y_traindf <- read.table(y_train, 
                header=FALSE, 
                col.names = c("activity_id"))

#  and merge these two data frames based on the commmon id being careful to avoid
#  changing the order (sort=FALSE)
mergedf <- merge(y_traindf, actdf, 
                 by.x="activity_id", by.y="activity_id", 
                 all=TRUE, 
                 sort=FALSE)

#  now read the subject id (i.e. person id) and giver it a column name
subdf <- read.table(subject, 
                header=FALSE, 
                col.names=("subject_id"))

#  and cbind this as a new column
fulldf <- cbind(subdf, mergedf)

#  Now read the big results table
trainvardf <- read.table(X_train, 
                header=FALSE, 
                strip.white = TRUE)

#  and the column header names
featdf <- read.table(features, 
                header=FALSE, 
                col.names=c("id", "feature"))

#  Now remove the open/close parenthesis "()" at the end of most of the 
#  feature names to make column headings more human friendly
featdf <- as.data.frame(sapply(featdf, 
                               gsub, 
                               pattern="\\()", 
                               replacement=""))

#  extract the column names and name the columns in the data frame
name <- featdf[, "feature"]
colnames(trainvardf) = name

#  and finally cbind together
train_finaldf <- cbind(fulldf, trainvardf)

#  now rbind the test and train data frame together to create a full combined data frame

combineddf <- rbind(test_finaldf, train_finaldf)

#  clean up memory
rm(list=c("actdf", 
          "y_traindf", 
          "mergedf", 
          "subdf", 
          "fulldf", 
          "trainvardf", 
          "featdf","name"))

#  and the individual data frames

rm(list=c("test_finaldf", 
          "train_finaldf"))

#  Now write the file out
#  write.table(combineddf, file="combined dataset.csv", sep=",", row.names=FALSE)

#  Stage Two: Extracts only the measurements on the mean and standard deviation 
#  for each measurement

#  Place the merged data frame into a data frame table suitable for use with dplyr
data <- tbl_df(combineddf)

#  and select only the row headers plus any measurement variable containing the 
#  strings "-mean" or "-std and omit "meanFreq"
sub_df <- select(data, subject_id, activity_name, 
                 contains("-mean"), 
                 contains("-std"), 
                 -contains("meanFreq"))

#  Stage Three: summarise the average of each measurement variable for each 
#  activity and each subject

#  again using dplyr, group by subject_id and activity_name and then pass 
#  to summarise_each to get the mean of each measurement 
final_tidy_df <- 
        sub_df %>% 
        group_by(subject_id, activity_name) %>% 
        summarise_each(funs(mean)) 

#  Now finally save the file for submission
write.table(final_tidy_df, 
            file="final tidy submission.txt", 
            sep=" ", 
            row.names=FALSE)

