################ step 1 ###################
# read datasets into R 
library(data.table)
test.labels <- read.table("test/y_test.txt", col.names="label") 
test.subjects <- read.table("test/subject_test.txt", col.names="subject") 
test.data <- read.table("test/X_test.txt") 
train.labels <- read.table("train/y_train.txt", col.names="label") 
train.subjects <- read.table("train/subject_train.txt", col.names="subject") 
train.data <- read.table("train/X_train.txt") 
 
# combine data together 
data <- rbind(cbind(test.subjects, test.labels, test.data), 
cbind(train.subjects, train.labels, train.data)) 


################ step 2 ###################
# read the features dataset 
features <- read.table("features.txt",stringsAsFactors=FALSE) 
# select features with mean and standard deviation 
features_mean_std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ] 

# select means and standard deviations from data 
# increment by 2 because data has subjects and labels in the beginning 
data_mean_std <- data[, c(1, 2, features_mean_std$V1+2)] 



################ step 3 ###################
# read the activity_labels datasets 
act_labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE) 
# Replacing numeric labels of activity in column 2 of the data frame
# (from 1 to 6) by descriptive strings which come from the file activity_labels.txt.
data_mean_std$label <- act_labels[data_mean_std$label, 2] 



################ step 4 ###################
# get a list of the current column names and feature names
name2 <- c("subject", "label", features_mean_std$V2) 

#Rename the colname of data_mean_std with gsub order
name2 <- gsub("[(][)]", "", name2)
name2 <- gsub("^t", "TimeDomain_", name2)
name2 <- gsub("^f", "FrequencyDomain_", name2)
name2 <- gsub("Acc", "Accelerometer", name2)
name2 <- gsub("Gyro", "Gyroscope", name2)
name2 <- gsub("Mag", "Magnitude", name2)
name2 <- gsub("-mean-", "_Mean_", name2)
name2 <- gsub("-std-", "_StandardDeviation_", name2)
name2 <- gsub("-", "_", name2)
names(data_mean_std) <- name2


################ step 5 ###################
final_data <- aggregate(data_mean_std[, 3:ncol(data_mean_std)], 
                       by=list(subject = data_mean_std$subject,
                               label = data_mean_std$label), mean) 

#Output final data 
write.table(x = final_data, file = "final_data.txt", row.names = FALSE)
