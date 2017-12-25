# Getting-and-Cleaning-Data
steps carried out are:

load the various libraries like dplyr,rlist,stringr etc.

use read.table to load the training and test data sets.

also load the subject and the activity list files.

The dimensions of subject , activity and training andtest are such that they can be merged as follows: a) first combine subject and test && subject and Y_train using bind_cols respectively b) use the output of step a to combine seperately with X_test and X_train c) finally combine row wise the output of step b.

Next use the grepl function to identify a list of index (boolean mask) for identifying the mean and std from the features.txt file 6.Next proceed to clean up the variable names.

Convert the activity codes into activity in text, by indexing a lookup into the dataframe. 8.Further clean up the variables.

Remove duplicates combination of subject and activity, by using the mean values, as subsititute of the range of values.

datset is now tidy and is written to a text file.
