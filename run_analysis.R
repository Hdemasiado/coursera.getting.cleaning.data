# step 1 
# read the data 
test_labels <- read.table("test/y_test.txt", col.names="label") 
test_subjects <- read.table("test/subject_test.txt", col.names="subject") 
test_data <- read.table("test/X_test.txt") 
train_labels <- read.table("train/y_train.txt", col.names="label") 
train_subjects <- read.table("train/subject_train.txt", col.names="subject") 
train_data <- read.table("train/X_train.txt") 

# bind together with the fields: subjects, labels, everything else 
data <- rbind(cbind(test_subjects, test_labels, test_data), cbind(train_subjects, train_labels, train_data)) 

# step 2 
# file with features (features.txt) is read 
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE) 
# keep onlyl features of mean and standard deviation 
features_mean_std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ] 


# get only  means and standard deviations
# increment by 2 as data file has subjects and labels 
data_mean_std <- data[, c(1, 2, features_mean_std$V1+2)] 

# step 3 
# read the labels from activities_labels.txt file
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE) 
# replace labels in data with label names 
data_mean_std$label <- labels[data_mean_std$label, 2] 

# step 4 
# creation of a list with column names and feature names 
good_colnames <- c("subject", "label", features_mean_std$V2) 
# tidy the good_colnames list, getting rid of non-alphabetic character
# and converting to lowercase 
good_colnames <- tolower(gsub("[^[:alpha:]]", "", good_colnames)) 
# use list as column names for data 
colnames(data_mean_std) <- good_colnames

# step 5 
# calculate mean for each combination of subject and label 
aggr_data <- aggregate(data_mean_std[, 3:ncol(data_mean_std)], 
                       by=list(subject = data_mean_std$subject,  
                               label = data_mean_std$label), 
                       mean) 


# write the data with write.table and getting rid of row names 
write.table(format(aggr_data, scientific=T), "tidyData.txt", 
            row.names=F, col.names=F, quote=2)
