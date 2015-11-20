#Coursera - Getting and Cleaning Data - Course Project

This README file describes the processing steps carried out in the *run_analysis.R* script to create a set of tidy data from the various source files as described in the Corsera Getting and Cleaning Data course project.

The source data files are found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and are described in the README.txt file found in the root directory of the zip file.

###Data File Location
This script requires the source data files above to be downloaded and extracted into the parent directory of this script without changing any of the path names from what is specified in the zip file.  That is, relevant to the directory that this script in in, the data must be in "*../UCI HAR Dataset/*".  
  
**IMPORTANT -** This script will not work if the source data is stored anywhere else or the original file names or path names are changed.

###Stage 1
The objective of the first stage of the run_analysis.R script is to merge the training and test datasets into one dataset, with human readable activity names (such as "walking") and with the "*features.txt*" measurement names added as column headings to the large measurement datasets.  Stage 1 does most of the "*heavy lifting*" for this course project.

To achieve this, it does the following:

1. reads and merges the activity id file (*y_test.txt*) with the activity names (*activity_labels.txt*) based on the id field in the *activity_label.txt* file.  This creates a data frame of relative activity id's with the relevant (human readable) activity label.

2. Reads the "*subject_test.txt*" id's (i.e. people taking part in the test) and adds them as a new column in the data frame created in step one (through cbind) in the same relative order so that we now have the non-measurement parts of each observation created.

3. Reads the big set of measurement variables (*X_test.txt*) from the "test" directory and the variable names from the "*features.txt*" file, the latter will be the column names.  To make nicer human-readable column names, I remove the open/close parenthesis "()" from most of the names.  Then add the feature names list as column headings to the measurement variables.  (no NA results were found in testing)
**NB:** The "*features.txt*" file variable names contain errors (duplicate values).  This is mentioned on the course discussion forum, where it is stated as an error in data preparation "the people assembling the data left off the x,y, and z".  Since this is an error in course preparation I corrected it in the source "*features.txt*" file rather than programatically in the *run_analysis.R* script.

4. Merges the data frame created in steps 1&2 with the data frame created in step 3 to make a single single merged data frame of the "test" data

5. Repeat steps 1-4 for the "train" related datasets

6. Combines the "test" and "train" data frames created above into a single data frame (Note: during testing this data frame was wriiten out to disk via table.write as a CSV for inspection. This is commented out in the final version).  

7. Clean up the environment to save memory etc. 

At this stage the combined data frame will have headings as follows:

"subject_id activity_id activity_name tBodyAcc-mean-X ..." followed by 560 other measurement names

###Stage 2
The objective of the second stage of the *run_analysis.R* script is to extract only the measurements on the mean and standard deviation for each measure.  These are identified as containing the text "-mean" or "-std" anywhere in the measurement name (column name) and specifically omitting the text "meanFreq".  

This was achieved using dplyr due to the ease of extracting variables that "contain" specified text. (It was also very helpful while debugging the script) 

###Stage 3
The objective of the third stage is to create the final dataset as an independant tidy dataset with the average of each measurement variable for each activity and each subject

Again this was achieved using dplyr tools and chaining (or piping) to take the data frame from the previous step and pipe it to group_by on the subject_id and activity_name fields and then pipe that to summarise_each with the mean function.  This results in a final data frame that looks as follows:

subject_id | activity_name | tBodyAcc-mean-X | tBodyAcc-mean-Y | (and 64 other columns)
--- | --- | --- | --- | ---
1 | STANDING | 0.265696921 | -0.018298173 | ..
2 | STANDING | 0.273113116 | -0.019132318 | ..
3 | STANDING | 0.27342872 | -0.017856067 | ..

Thus meeting the course instructions as well as the definition of a tidy dataset being:

* Each variable in its own column
* Each observation forming its own row
* Each type of observational unit forms a table
* The first row contains human-readable variable names

This data frame is written to disk as *final tidy submission.txt*.

The final tidy dataset can be read into R via: df <- read.table("final tidy submission.txt", header=TRUE, sep=" ")

###Codebook
A fuller desciption of the tidy dataset can be found in the code book (*CodeBook.md*) found in this GitHub repo. 
