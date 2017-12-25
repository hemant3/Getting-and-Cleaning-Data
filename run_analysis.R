> if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
file_path <- file.path("./data", "UCI HAR Dataset")
files <- list.files(file_path, recursive = TRUE)
##Read data from files into variables
dataActivityTest <- read.table(file.path(file_path, "test", "Y_test.txt"), header = FALSE)
dataActivityTrain <- read.table(file.path(file_path, "train", "Y_train.txt"), header = FALSE)
dataSubjectTrain <- read.table(file.path(file_path, "train", "subject_train.txt"), header = FALSE)
dataSubjectTest <- read.table(file.path(file_path, "test", "subject_test.txt"), header = FALSE)
dataFeaturesTest <- read.table(file.path(file_path, "test", "X_test.txt"), header = FALSE)
dataFeaturesTrain <- read.table(file.path(file_path, "train", "X_train.txt"), header = FALSE)
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)
##Merging training and test sets
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(file_path, "features.txt"), head = FALSE)
names(dataFeatures) <- dataFeaturesNames$V2
dataMerge <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataMerge)
##Extracting measurements on the mean and Standard deviation
subsetdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selNames <- c(as.character(subsetdataFeaturesNames), "subject", "activity")
Data <- subset(Data, select = selNames)
activityLabels <- read.table(file.path(file_path, "activity_labels.txt"), header = FALSE)
##labeling variables
names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data)
library(dplyr)
##creating separate tidy dataset
tidydata <- aggregate(. ~subject + activity, Data, mean)
tidydata <- tidydata[order(tidydata$subject, tidydata$activity),]
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)
library(knitr)
knit2html("codebook.Rmd");



