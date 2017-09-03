
## Set Working Directory and Clean
setwd("~/Dropbox/Data Science/Hopking University/C3_Getting_and_cleaning_data/Week4/Project")
rm(list = ls())

## Loading library
library(reshape2)

## Name Zip
filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels + features
activityLab <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLab[,2] <- as.character(activityLab[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
fw <- grep(".*mean.*|.*std.*", features[,2])
fw.names <- features[fw,2]
fw.names = gsub('-mean', 'Mean', fw.names)
fw.names = gsub('-std', 'Std', fw.names)
fw.names <- gsub('[-()]', '', fw.names)

# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[fw]
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSub, trainAct, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[fw]
testAct <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSub, testAct, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", fw.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLab[,1], labels = activityLab[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
