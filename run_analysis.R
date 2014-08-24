# Function that analyzes data from a Human Activity Recognition Using Smartphones
# study.  The source data is in two sets:  training and test.  The datasets
# are combined into a single dataset, which is then reshaped to produce means
# of each standard deviation and mean value variable for each test subject and
# each physical activity that was observed.  The resultant dataset is written
# to a file named subjectActivityMeans.txt.
run_analysis <- function() {
    
    # Combine the X data
    combinedX <- getCombinedXData()
    
    # Add the features as column names for the X data.
    # Also remove the "()" and replace the "-" characters with "_" for readability.
    features <- getAllFeatures()
    variableNames <- gsub( "-", "_", features[,2])
    variableNames <- gsub( "()", "", variableNames, fixed = TRUE)
    colnames(combinedX) <- variableNames
    
    # Subset the data to include only mean and std features
    justMeanAndStdFeatures <- filterMeanAndStdFeatures(features)
    meanAndStd <- combinedX[, justMeanAndStdFeatures$Index]
    
    # Attach activity data
    meanAndStdWithY <- attachActivity( meanAndStd )
    
    # Attach subjects data
    completeData <- attachSubject( meanAndStdWithY )
    
    # Get the distinct list of subjects
    subjects <- unique( completeData$subject)
    
    # Get the distinct list of activities
    activities <- unique( completeData$activity)
    
    # Initialize a data frame for output
    finalData = data.frame()
    
    usedVariables <- colnames(meanAndStd)
    
    # Compute the average of each variable for each activity for each subject.
    for( i in seq_len(length(subjects))) {
        
        subject <- subjects[i]
        
        for( j in seq_len(length(activities))) { 
        
            activity <- activities[j]
            
            for( k in seq_len(length(usedVariables))) { 
                
                variable <- usedVariables[k]
                
                # Subset by subject, activity, variable
                subActVarData <- completeData[ completeData$subject == subject & completeData$activity == activity, variable]
                
                meanValue <- mean( subActVarData)
                
                rec = data.frame( Subject = subject, Activity = activity, Variable = variable, Mean = meanValue )
                finalData <- rbind(finalData, rec)
            }
            
        }
    }
    
    # Write data to file
    write.table( finalData, file="./subjectActivityMeans.txt", row.names=FALSE)
    
    finalData
    
}

# Attach measurement subjects to the data
attachSubject <- function( xData ) {
    
    # Combine the subject data from test and training
    testSubject <- readData( "./UCI HAR Dataset/test/subject_test.txt")
    trainSubject <- readData( "./UCI HAR Dataset/train/subject_train.txt")
    
    allSubjects <- rbind(testSubject, trainSubject)
    colnames(allSubjects) <- c("subject")
    
    xData <- cbind( xData, allSubjects)
    
    xData
}

# Attach the activity labels to the dataset
attachActivity <- function( xData ) {
    
    # Combine the Y data from test and training
    testY <- readData( "./UCI HAR Dataset/test/y_test.txt")
    trainY <- readData( "./UCI HAR Dataset/train/y_train.txt")
    
    allY <- rbind(testY, trainY)
    colnames(allY) <- c("Y")
    
    # Attach the descriptive label names
    lookup <- getActivityLabels()
    for( i in seq_len(nrow(allY))) {
        activity <- lookup[ lookup$Value == allY$Y[i], ]
        xData$activity[i] <- as.character(activity$Name)
    }

    xData
}

# Read in activity labels
getActivityLabels <- function() {
    
    labels <- readData("./UCI HAR Dataset/activity_labels.txt")
    colnames(labels) <- c("Value", "Name")
    
    labels
}

# Read in the test and training data,
# and combine the two sets.  T
getCombinedXData <- function() {
    
    # Read in the test data
    testX <- readData( "./UCI HAR Dataset/test/X_test.txt")
    
    # Read in the training data
    trainX <- readData( "./UCI HAR Dataset/train/X_train.txt")
    
    # Combine the data
    combinedX <- rbind(testX,trainX)
    
    combinedX
}

# Read in all features
getAllFeatures <- function() {
    
    features <- readData("./UCI HAR Dataset/features.txt")
    colnames(features) <- c("Index", "Name")
    
    features
}

# Function to extract just the mean and standard deviation features
# from the master features list.
filterMeanAndStdFeatures <- function( features ) {
    
    # Get all features that are either means or standard deviations
    # Use the pattern that all mean features contain "mean()" and
    # all standard deviation features contain "std()".
    meanAndStdFeatures <- grepl(pattern="(mean\\(\\)|std\\(\\))",features$Name)
    
    justMeanAndStdFeatures <- features[ meanAndStdFeatures, ]
    
    justMeanAndStdFeatures
}

# Given a file path, load the file's data into 
# a data frame.
readData <- function( filePath ) {
    
    df <- read.table(filePath, header=FALSE)
    df
}