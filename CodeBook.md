**CONTENT**
-  DESCRIPTION OF "Averages.txt"
-  STEPS TO CONSTRUCT "Averages.txt" 

**DESCRIPTION OF "Averages.txt"**

This data set contains 180 rows (resulting from the combination of 30 subjects and 6 activities) and 68 columns. 
The first column contains the subject number (ranging from 1 to 30), the second column contains the name of the activity (the six possible activities are  LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS), while all the other columns are the averages of the quantities indicated by the column names for each subject and activity combination  (eg: the first row of column 3 is the average of the x component of body acceleration for subject 1 and activity "LAYING"). 

The units of measures of the variables in column 3 through column 68 are the same as those in the original data. 
See file UCI\ HAR \Dataset/features_info.txt for details. 

**Column names:**
-  Subject 
-  Activity 
-  tBodyAcc-mean()-X
-  tBodyAcc-mean()-Y
-  tBodyAcc-mean()-Z
-  tBodyAcc-std()-X
-  tBodyAcc-std()-Y
-  tBodyAcc-std()-Z
-  tGravityAcc-mean()-X
-  tGravityAcc-mean()-Y
-  tGravityAcc-mean()-Z
-  tGravityAcc-std()-X
-  tGravityAcc-std()-Y
-  tGravityAcc-std()-Z
-  tBodyAccJerk-mean()-X
-  tBodyAccJerk-mean()-Y
-  tBodyAccJerk-mean()-Z
-  tBodyAccJerk-std()-X
-  tBodyAccJerk-std()-Y
-  tBodyAccJerk-std()-Z
-  tBodyGyro-mean()-X
-  tBodyGyro-mean()-Y
-  tBodyGyro-mean()-Z
-  tBodyGyro-std()-X
-  tBodyGyro-std()-Y
-  tBodyGyro-std()-Z
-  tBodyGyroJerk-mean()-X
-  tBodyGyroJerk-mean()-Y
-  tBodyGyroJerk-mean()-Z
-  tBodyGyroJerk-std()-X
-  tBodyGyroJerk-std()-Y
-  tBodyGyroJerk-std()-Z
-  tBodyAccMag-mean()
-  tBodyAccMag-std()
-  tGravityAccMag-mean()
-  tGravityAccMag-std()
-  tBodyAccJerkMag-mean()
-  tBodyAccJerkMag-std()
-  tBodyGyroMag-mean()
-  tBodyGyroMag-std()
-  tBodyGyroJerkMag-mean()
-  tBodyGyroJerkMag-std()
-  fBodyAcc-mean()-X
-  fBodyAcc-mean()-Y
-  fBodyAcc-mean()-Z
-  fBodyAcc-std()-X
-  fBodyAcc-std()-Y
-  fBodyAcc-std()-Z
-  fBodyAccJerk-mean()-X
-  fBodyAccJerk-mean()-Y
-  fBodyAccJerk-mean()-Z
-  fBodyAccJerk-std()-X
-  fBodyAccJerk-std()-Y
-  fBodyAccJerk-std()-Z
-  fBodyGyro-mean()-X
-  fBodyGyro-mean()-Y
-  fBodyGyro-mean()-Z
-  fBodyGyro-std()-X
-  fBodyGyro-std()-Y
-  fBodyGyro-std()-Z
-  fBodyAccMag-mean()
-  fBodyAccMag-std()
-  fBodyBodyAccJerkMag-mean()
-  fBodyBodyAccJerkMag-std()
-  fBodyBodyGyroMag-mean()
-  fBodyBodyGyroMag-std()
-  fBodyBodyGyroJerkMag-mean()
-  fBodyBodyGyroJerkMag-std()


**STEPS TO CONSTRUCT "Averages.txt"** 

Starting from the data in the directory "UCI HAR Dataset" (obtained by downloading and unzipping the file available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)), the tidy dataset "Averages.txt" is constructed through the following steps in the script run_analysis.R:

- bind by column the files subject_test.txt, y_test.txt and X_test.txt located in UCI HAR Dataset/test/ to form a table called test_data. The table test_data contains a column with the subject number, a columun with the activity and 561 other columns containing the features listed in UCI HAR Dataset/features.txt.
- bind by column the files subject_train.txt, y_train.txt and X_train.txt located in UCI HAR Dataset/train/ to form a table called train_data. The table train_data contains a column with the subject number, a columun with the activity and 561 other columns containing the features listed in UCI HAR Dataset/features.txt.
- bind by row test_data and train_data in a table called all_data. 
- "extract only the measurements on the mean and standard deviation for each measurement." This is achieved by first reading the file features.txt in a table called "features" and then selecting the variable names which contain either the string "mean()" or "std()". To this end, the vector mean_or_std_positions is constructed by grepping "mean()" or "std()" in features$names.  NOTE: for the sake of consistency, variable names containing the string "meanFreq" such as fBodyBodyGyroJerkMag-meanFreq() are ignored because they are **weighted** averages over the frequencies, thus resulting from a  different mathematical operation than arithmetic mean and in not having an associated standard deviation. 
- "use descriptive activity names to name the activities in the data set." This is achieved by exploiting the file UCI HAR Dataset/activity_labels.txt and replacing the numbers appearing in the column "activity" in all_data with the corresponding name.
- "appropriately label the data set with descriptive variable names." This is achieved by replacing the automatic column names "V1", "V2", etc. with the names appearing in features.txt exploiting the vector mean_or_std_positions constructed two steps above.
- "From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject." This is achieved by grouping all_data by subject and then by activity, then computing the group averages and storing them in a table called tidy_data. This dataset is tidy according to the criteria list in the section "The tidy data" [here](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/01_03_componentsOfTidyData/index.Rmd).


NOTE: given the [requirements of the assignment](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project) and following the [David Hood's advice] (https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) I ignored the files in the folders test/Inertial\ Signals and train/Inertial\ Signals and directly used test/X_test.txt and train/X_train.txt 







