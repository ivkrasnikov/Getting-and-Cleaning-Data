# Getting and Cleaning Data Project

The course project for the Getting and Cleaning Data Coursera course.
The project includes script 'run_analysis.R'

1. Script loads the data from "UCI HAR Dataset" (must be in the same directory)
2. General labels load from files:
	* `features.txt`
	* `activity_labels.txt`
3. Script loads training and test dataset using read.table functions into separate tables, keeping only columns containing a mean or standard deviation
4. Test and training dataset has a marker-column "is_test" to separate dataset in future
5. Merges the two datasets
6. Converts the integer `activity` column into a factor
7. Script clears the memory after each blok of tasks
8. Creates an independent tidy data set (`tidy_data.txt`) with the average of each variable for each activity and each subject.
