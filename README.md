# getcleandata
Repo for the Getting and Cleaning Data Coursera module

This README file describes the processing steps carried out in the run_analysis.R script to create a set of tidy data from the sources files described in the Corsera Getting and Cleaning Data course project.

The source files are found here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and described in the README.txt file found in the root directory of the zip file.

At a high-level the run_analysis.R script does the following:
1. Reads the files that are common to both test and train datasets (activity name) and adds
1. Reads the files that are common to both test and train datasets (activity name) and adds
2. Reads the set of data in the "test" directory and the activit names and merges
