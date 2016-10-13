# Peer graded assignment in week 4 of Coursera "Getting and cleaning data" course.

Starting from the data in the "UCI HAR Dataset" available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), the tidy dataset "Averages.txt" is constructed through the following steps in the script run_analysis.R:

- bind by column the files subject_test.txt, y_test.txt and X_test.txt located in UCI HAR Dataset/test/ to form a table called test_data. The table test_data contains a column with the subject number, a columun with the activity and 561 other columns containing the features listed in UCI HAR Dataset/features.txt.
- bind by column the files subject_train.txt, y_train.txt and X_train.txt located in UCI HAR Dataset/train/ to form a table called train_data. The table train_data contains a column with the subject number, a columun with the activity and 561 other columns containing the features listed in UCI HAR Dataset/features.txt.
- bind by row test_data and train_data in a table called all_data. 
- "extract only the measurements on the mean and standard deviation for each measurement." This is achieved by first reading the file features.txt in a table called features and then selecting the variable names which contain either the string "mean()" or "std()". To this end, the vector mean_or_std_positions is constructed by grepping "mean()" or "std()".  NOTE: for the sake of consistency, variable names containing the string "meanFreq" such as fBodyBodyGyroJerkMag-meanFreq() are ignored because they are **weighted** averages over the frequencies, thus resulting from a  different mathematical operation than arithmetic mean. 
- "use descriptive activity names to name the activities in the data set." This is achieved by exploiting the file UCI HAR Dataset/activity_labels.txt and replacing the numbers appearing in the column "activity" in all_data with the corresponding name.
- "appropriately label the data set with descriptive variable names." This is achieved by replacing the automatic column names "V1", "V2", etc. with the names appearing in features.txt and exploiting the vector mean_or_std_positions constructed two steps above.
- "From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject." This is achieved by grouping all_data by subject and then by activity, then computing the group averages and storing them in a table called tidy_data. 


NOTE: given the [requirements of the assignment](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project) and following the [David Hood's advice] (https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) I ignored the files in the folders test/Inertial\ Signals and train/Inertial\ Signals and directly used test/X_test.txt and train/X_train.txt 

-----------

**Repository content**:
- folder "UCI HAR Dataset" as obtained by unzipping the file available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- README.md
- Averages.txt
- run_analysis.R

