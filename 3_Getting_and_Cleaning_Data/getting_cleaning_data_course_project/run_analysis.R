# Load labels and features
features <- read.table("data/features.txt")
activity_labels <- read.table("data/activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity")

# Load "test" data
x_test <- read.table("data/test/X_test.txt")
y_test <- read.table("data/test/y_test.txt")
subject_test <- read.table("data/test/subject_test.txt")

# Load "train" data
x_train <- read.table("data/train/X_train.txt")
y_train <- read.table("data/train/y_train.txt")
subject_train <- read.table("data/train/subject_train.txt")

# Merge test and train subject data
subject <- rbind(subject_test, subject_train)

# Merge test and train label ids then merge in the labels
activities <- rbind(y_test, y_train)
colnames(activities) <- c("activity_id")
activities <- merge(activities, activity_labels)[,2]

# Merge the test and train set
set <- rbind(x_test, x_train)

# column names of datya set come from features table
colnames(set) <- features[,2]

# Bind the columns of the subjects, the activities and the data set
all_data <- cbind(subject_all, activities, set)

# Extract only the measurements on the mean and standard deviation for each measurement
mean_sd_cols <- grep("-mean|-std", colnames(all_data))
mean_sd_data <- all_data[,c(1,2,mean_sd_cols)]

# Melt the data down to one observation for each subject & activity
data_melted <- melt(mean_sd_data, id.var = c("subject", "activities"))

# Compute the means, grouped by subject & activity
data_means = dcast(data_melted, subject + activities ~ variable, mean)

# Write table and display the means
write.table(data_means, "data/data_means.txt")
data_means


