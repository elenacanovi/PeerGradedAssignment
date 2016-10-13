#Useful libraries
library(dplyr)
#--------
#Sets working directory and the path to UCI HAR Dataset folder.

#1. Variable with the working directory
MyWorkingDirectory<-getwd()
setwd(MyWorkingDirectory)

#2. Variable with the path to folder "UCI HAR Dataset" (change with your path)
AssignmentDataFolder<-paste(MyWorkingDirectory,"/UCI\ HAR\ Dataset/",sep="/")

#--------
#Reads the relevant test and train files

subject_test<-read.table(paste(AssignmentDataFolder,"test/subject_test.txt",sep="/"),col.names = "subject")
subject_train<-read.table(paste(AssignmentDataFolder,"train/subject_train.txt",sep="/"),col.names = "subject")

activity_test<-read.table(paste(AssignmentDataFolder,"test/y_test.txt",sep="/"),col.names = "activity")
activity_train<-read.table(paste(AssignmentDataFolder,"train/y_train.txt",sep="/"),col.names = "activity")

derived_test<-read.table(paste(AssignmentDataFolder,"test/X_test.txt",sep="/"))
derived_train<-read.table(paste(AssignmentDataFolder,"train/X_train.txt",sep="/"))

#--------
#Merges the training and the test sets to create one data set.

#1. Merges by column subject,activity,derived dataframes separately for test and train data
test_data<-cbind(subject_test,activity_test,derived_test)
train_data<-cbind(subject_train,activity_train,derived_train)

#2. Merges by row test_data and train_data
all_data<-rbind(test_data,train_data)

#----------
#Extracts only the measurements on the mean and standard deviation for each measurement.

#1. Reads the feature file.
features<-read.table(paste(AssignmentDataFolder,"features.txt",sep="/"),col.names = c("number","name"),stringsAsFactors = FALSE)

#2. Finds the variables (i.e. their column in all_data) which contain "mean()" and "std()" in their name. The +2 is due to the fact that the first variable in features is the fourth column of all_data, the second variable in features in the fifth column in all_data etc... (Note the escape characters before the parentheses in "mean\\(\\)")
mean_or_std_positions<-as.vector(grep("mean\\(\\)|std()",features$name))+2 

#3. Selects only the relevant variables in all_data (subject, group, activity and the variables containing means and standard deviations)
all_data<-select(all_data,append(c(1,2),mean_or_std_positions))

#------------
#Uses descriptive activity names to name the activities in the data set

#1.Reads the activity file "activity_labels.txt"
activity_map<-read.table(paste(AssignmentDataFolder,"activity_labels.txt",sep="/"),col.names = c("number","name"),stringsAsFactors = FALSE)

#2. Creates a vector with the names of activities (one row for each row of all_data)
activity_name<-character()
for (act_number in all_data$activity){
        activity_name<-append(activity_name,activity_map$name[act_number])
}

#3. Replaces the column the activity numbers in all_data with their name 
all_data<-mutate(all_data,activity=activity_name)

#Appropriately labels the data set with descriptive variable names.
# Uses the names available in the file "features"
for (i in 1:length(mean_or_std_positions)){
        colnames(all_data)[2+i]<-features$name[mean_or_std_positions[i]-2]
}

#---------
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#1. Groups first by subject and then by activity
grid_data<-all_data %>% group_by(subject,activity)

#2. Computes the means with summarize_each
tidy_data<-summarize_each(grid_data,funs(mean),`tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`)

#3. Exports tidy_data to file "Averages.txt"
write.table(tidy_data,file="Averages.txt",row.names = FALSE)




