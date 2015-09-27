# Code Book

This document describes the code inside `run_analysis.R`.

The code is split into following sections:

* Variables for storing file paths
* Read data from files load them into data frames using read.table.
* Assigning column names to data frames.
* A loop to match column names containing "std()" and "mean()" in features.txt and store the result in *filtered\_features\_data* variable.
* Get subset of *training* and *test* data using filtered column names.
* Combine subject, activity and reading using cbind.
* Combine training and test data using rbind.
* Calculate average of each variable for each activity and each subject using ddply function in plyr package.
* Writing final data to output.txt.

#Input
run_analysis.R expects input containing the path where UCI test data is located. The input directory should have the following file(s) and folder.

* *features.txt* file
* *activity_labels.txt* file
* *test* folder
* *train* folder

*test* folder should have the following files:

* *X_test.txt* file
* *y_test.txt* file
* *subject_test.txt* file

*train* folder should have the following files:

* *X_train.txt* file
* *y_train.txt* file
* *subject_train.txt* file


#Output

The script creates output file named *output.txt* in the input path.
