run_analysis <- function(directory) {
  # variables for storing file paths
  x_train_file_path <- file.path(directory, "train/X_train.txt")
  y_train_file_path <- file.path(directory, "train/y_train.txt")
  subject_train_file_path <- file.path(directory, "train/subject_train.txt")
  
  x_test_file_path <- file.path(directory, "test/X_test.txt")
  y_test_file_path <- file.path(directory, "test/y_test.txt")
  subject_test_file_path <- file.path(directory, "test/subject_test.txt")
  
  features_file_path <- file.path(directory, "features.txt")
  activity_label_file_path <- file.path(directory, "activity_labels.txt")
  output_file <- file.path(directory, "output.txt")
  
  # read data from files
  features_data <- read.table(features_file_path, sep = "", na.strings = "", header = F)
  activity_data <- read.table(activity_label_file_path, sep = "", na.strings = "", header = F)
  x_train_data <- read.table(x_train_file_path, sep = "", na.strings = "", header = F)
  x_test_data <- read.table(x_test_file_path, sep = "", na.strings = "", header = F)
  y_train_data <- read.table(y_train_file_path, sep = "", na.strings = "", header = F)
  y_test_data <- read.table(y_test_file_path, sep = "", na.strings = "", header = F)
  subject_test_data <- read.table(subject_test_file_path, sep = "", na.strings = "", header = F)
  subject_train_data <- read.table(subject_train_file_path, sep = "", na.strings = "", header = F)
  
  filtered_features_data <- data.frame(colno=integer(0), colname=character(0))
  
  # assign column names to data frames
  names(features_data) <- c("colno", "colname")
  names(subject_train_data) <- c("subject")
  names(subject_test_data) <- c("subject")
  names(y_train_data) <- c("activity")  
  names(y_test_data) <- c("activity")
  names(x_train_data) <- features_data[, 2]
  names(x_test_data) <- features_data[, 2]
  
  # get column names matching std() and mean() and store it in filtered_features_data
  for (i in features_data[, 1]) {
    if ((length(grep("std\\(\\)", features_data[i, 2])) > 0) |
        (length(grep("mean\\(\\)", features_data[i, 2])) > 0)){
      filtered_features_data <- rbind(filtered_features_data, features_data[i, ])
    }
  }
  
  # get subset of training and test data using filtered names
  x_train_data_subset <- x_train_data[, filtered_features_data[, 1]]
  x_test_data_subset <- x_test_data[, filtered_features_data[, 1]]
  
  combined_train_data <- cbind(subject_train_data, y_train_data, x_train_data_subset)
  combined_test_data <- cbind(subject_test_data, y_test_data, x_test_data_subset)
  
  # merge training and test data vertically
  combined_data <- rbind(combined_train_data, combined_test_data)
  
  # calculate average of each variable for each activity and each subject
  library(plyr)
  cdata <- ddply(combined_data, c("subject", "activity"), colMeans)
  # cdata
  
  write.table(cdata, file = output_file, row.name=FALSE)
}
