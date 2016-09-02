## Load data.table library
## Execute functions sequentially

loadData <- function() {
  ## Load training set and test set
  trainingSet <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
  trainingSetLabels <- read.table(file = "UCI HAR Dataset/train/y_train.txt", col.names = c("ActivityID"), stringsAsFactors = FALSE)
  
  testSet <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
  testSetLabels <- read.table(file = "UCI HAR Dataset/test/y_test.txt", col.names = c("ActivityID"), stringsAsFactors = FALSE)
  
  ## Load lookup information
  featureList <- read.table(file = "UCI HAR Dataset/features.txt", col.names = c("FeatureID", "FeatureLabel"), stringsAsFactors = FALSE)
  activityList <- read.table(file = "UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityLabel"), stringsAsFactors = FALSE)
  
  ## Load Row ID or subject ID
  trainingSubjects <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", col.names = "SubjectID")
  testSubjects <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", col.names = "SubjectID")
  
  ## Load Activity ID
  activityList <- read.table(file = "UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityName"), stringsAsFactors = FALSE)
}
## IMPORTANT! FUSE TRAINING SET AND THEN TEST SET
initialCleaning <- function () {
  ## Replace Column Names for Training and Test Datasets
  colnames(trainingSet) <- featureList$FeatureLabel
  colnames(testSet) <- featureList$FeatureLabel
  
  ## Create Row IDs for final set
  subjectID <- rbind(trainingSubjects, testSubjects)
  
  ## Add Activity Names
  temp <- c(merge(trainingSetLabels, activityList, by = "ActivityID")$ActivityName, merge(testSetLabels, activityList, by = "ActivityID")$ActivityName)
  subjectID <- cbind(subjectID, temp)
  colnames(subjectID) <- c("SubjectID", "ActivityName")
  
  ## Merge trainingSet and testSet
  dataSet <- rbind(trainingSet, testSet)
  
  ## Merge Subject ID with merged dataSet
  dataSet <- cbind(subjectID, dataSet)
  
  ## Sort dataSet based on Subject ID
  dataSet <- dataSet[order(dataSet$SubjectID),]
}

manipulateTable <- function() {
  ## Extract data only with mean and standard deviation
  temp <- grepl (pattern = "SubjectID|ActivityName|mean|std", x = names(dataSet))
  dataSetWithMeanAndSD <- dataSet[,temp == TRUE]
  
  ## Convert to tbl_df
  dataSetWithMeanAndSD <- data.table(dataSetWithMeanAndSD)
  
  ## Compute mean and standard deviation
  dataSetWithMeanAndSD <- dataSetWithMeanAndSD[,lapply(.SD, mean), by = c("SubjectID", "ActivityName")]
  
  ## Write into File
  write.table(x = dataSetWithMeanAndSD, file = "FinalSummarisedAndSqueakyCleanData.txt")
}