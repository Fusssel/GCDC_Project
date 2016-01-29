run_analysis <- function() {      
        
    
        # Read the test and train datasets
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
        colnames(subject_test) <- "subject"
        
        activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
        colnames(activity_test) <- "activity"
        
        temp_data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
        
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
        colnames(subject_train) <- "subject"
        
        activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
        colnames(activity_train) <- "activity"
        
        temp_data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
        
        
        # import variable names and clean them up
        features <- read.table ( "UCI HAR Dataset/features.txt" , col.names = c ( "Column", "Name"), stringsAsFactors=FALSE )
        features[,2] <- gsub('\\(|\\)',"", features[,2], perl = TRUE)
        features[,2] <- gsub("-|,","_", features[,2])
        features[,2] <- gsub('^t',"TimeDomain.", features[,2])
        features[,2] <- gsub('^f',"FrequencyDomain.", features[,2])
        features[,2] <- gsub('Freq\\.',"Frequency.", features[,2])
        features[,2] <- gsub('Freq$',"Frequency", features[,2])
        
        # Assign variable names to datasets
        colnames(temp_data_test) <- features[,2]
        colnames(temp_data_train) <- features[,2]
        
        # Merge test and train datasets
        
        bind_data_test <- cbind(subject_test,activity_test,temp_data_test)
        bind_data_train <- cbind(subject_train,activity_train,temp_data_train)
        
        # Extract only columns with mean and standard deviation in test and train dataset
        data_test <- bind_data_test[,c(1,2,grep("_mean_|_mean$|_std_|_std$", names(bind_data_test)))]
        data_train <- bind_data_train[,c(1,2,grep("_mean_|_mean$|_std_|_std$", names(bind_data_train)))]    
          
        # Merge test and train dataset
        dataset <- rbind(data_test,data_train)
         
        # Load activity names
        activities <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = "character")
        colnames(activities) <- c("activity", "activity_name")
        
        # Combine activity names and dataset
        dataset <- merge(activities, dataset)
        dataset$activity_name <- tolower(dataset$activity_name)
        
        # Remove duplicate activity column
        temp_id <- names(dataset) %in% c("activity")
        dataset <- dataset[!temp_id]
        
                
        # Creates clean dataset with the average of each variable for each
        # activity and each subject and then orders it
        clean_data <- aggregate(dataset[,3:ncol(dataset)], by=list(subject=dataset$subject,activity_name=dataset$activity_name), FUN=mean, na.rm=TRUE)
        clean_data <- clean_data[order(clean_data$subject,clean_data$activity_name),]
        
        write.table(clean_data, "clean_data.txt", row.names=FALSE)
        
}
