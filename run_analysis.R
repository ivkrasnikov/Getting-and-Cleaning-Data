rm(list=ls(all=TRUE)) # Clear workspace
library(data.table)

# General labels
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ID", "Name"));
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("ID", "Name"));

# Extracts only the measurements on the mean and standard deviation for each measurement.
features_log <- grepl("mean|std", features$Name);

# Training part
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"));
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = c("activity"));
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$Name);
X_train <- X_train[,features_log];

is_test <- rep(FALSE, nrow(subject_train));

# Combining all table into one training dataset
train <- cbind(subject_train, is_test, Y_train, X_train);
names(train)[2] <- c("is_test");
rm(subject_train, is_test, Y_train, X_train); # Clear memory

# Test part
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"));
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = c("activity"));
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$Name);
X_test <- X_test[,features_log];

is_test <- rep(TRUE, nrow(subject_test));

# Combining all table into one testing dataset
test <- cbind(subject_test, is_test, Y_test, X_test);
names(test)[2] <- c("is_test");
rm(subject_test, is_test, Y_test, X_test); # Clear memory

# Merges the training and the test sets to create one data set.
data <- rbind(train, test);

# Make descriptive activity names in the data set
data$activity <- activity[data$activity,2];

rm(train, test); #Clear memory
gc(); # Garbage collector

# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
tidy_data <- aggregate(data[4:ncol(data)], data[,c("is_test", "activity", "subject")], FUN = mean)

write.table(tidy_data, file = "tidy_data.txt");

