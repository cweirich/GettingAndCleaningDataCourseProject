# These packages should be installed before this script is run
library(dplyr)
library(reshape2)

# Mount "test" and "train" tables, depending on the parameter
# These tables will have the following requirements of the assignment:
# * Only measurements with mean or std (req. 2)
# * Descriptive names of activities (req. 3)
# * Descriptive variable names (req. 4)
# And also will have all variables from subjects, activities and
# measurements joined in only one table, which is returned
mountTable <- function (target)
{
    # Go to data directory and get the labels for variables and activities
    setwd("data/")
    columnNames <- read.table("features.txt")
    activityLabels <- read.table("activity_labels.txt")
    
    # Go into the directory specified by the parameter
    setwd(target)
    
    # Create subjects dataset
    subjectsFile <- paste("subject_",target,".txt",sep="")
    subjects <- read.table(subjectsFile, col.names = "subject")
    
    # Create activites dataset
    activitiesFile <- paste("y_",target,".txt",sep="")
    activities <- read.table(activitiesFile)
    
    # Use the activities names from the file
    activities <- merge(activities, activityLabels)
    activities <- rename(activities, activity = V2)
    
    # Create measurements dataset
    measurementsFile <- paste("x_",target,".txt",sep="")
    measurements <- read.table(measurementsFile)
    
    # Use the column names read from the file
    colnames(measurements) <- columnNames$V2
    
    # Logic vector to show where are columns with mean or std on its names
    meanAndStdColumns <- grepl("mean\\(\\)", colnames(measurements)) | 
                         grepl("std\\(\\)", colnames(measurements))
    
    # Subset the dataset using the logic vector
    measurements <- measurements[, meanAndStdColumns]
    
    # Join the three datasets to create the table
    table <- cbind(subjects, select(activities, activity), measurements)
    
    # Return to the original directory
    setwd("../..")
    
    # Return the table
    as_tibble(table)
}

# Create the test table
testTable <- mountTable("test")

# Create the train table
trainTable <- mountTable("train")

# Merge the two tables (requirement 1)
wholeDataset <- rbind(testTable, trainTable)

# Melt the dataset using subject and activity
moltenDataset <- melt(wholeDataset, id.vars = c("subject", "activity"))

# Create a tidy dataset with averages (requirement 5)
tidyDataset <- dcast(moltenDataset, subject+activity ~ variable, mean)

# Write the final dataset to the working directory
write.table(tidyDataset, "tidydataset.txt", row.names = FALSE)