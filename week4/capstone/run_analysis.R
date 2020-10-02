## Capstone Project for "Getting and Cleaning Data" -- Erix Xie 


## Working directory should be set as "~/UCI HAR Dataset"
# when working directory is set up, run this function to get output
my_analysis_result() 

## this function below ONLY works when the working directory is well set
my_analysis_result <- function(){
  merged_df <- my_analysis()
  result <- my_analysis_2(merged_df)
  # pls comment out undesired write.table lines
  write.table(result,file = "second_tidy_dataset.csv",sep = ",",row.names = FALSE) # output as .csv
  write.table(result,file = "second_tidy_dataset.txt",row.names = FALSE) # output as .txt
  return(result) # uncomment if necessary
}




## my_analysis takes all necessary files and 
#  returns a tidy merged dataset consisting of only the columns about mean&std,
#  with descriptive activity names and variable names

my_analysis <- function(train_file = "train/X_train.txt",test_file = "test/X_test.txt",
                        train_sub_file = "train/subject_train.txt", train_y_file = "train/y_train.txt",
                        test_sub_file = "test/subject_test.txt", test_y_file = "test/y_test.txt"
                        ) {
  ## For each of train and test data sets, read the .txt file and store the 
  #  content to a dataFrame, then combine to train_df and test_df
  
  
  ######################## tedious reading files ########################
  train_x <- read.delim(train_file,header = FALSE, colClasses = "numeric", sep = "")
  train_sub <- read.delim(train_sub_file,header = FALSE, colClasses = "numeric", sep = "")
  names(train_sub) <- "subject"   # add variable name
  train_y <- read.delim(train_y_file,header = FALSE, colClasses = "numeric", sep = "")
  names(train_y) <- "activity"   # add variable name
  train_df <- cbind(train_x,train_sub,train_y)
  
  test_x <- read.delim(test_file,header = FALSE, colClasses = "numeric", sep = "")
  test_sub <- read.delim(test_sub_file,header = FALSE, colClasses = "numeric", sep = "")
  names(test_sub) <- "subject"   # add variable name
  test_y <- read.delim(test_y_file,header = FALSE, colClasses = "numeric", sep = "")
  names(test_y) <- "activity"   # add variable name
  test_df <- cbind(test_x,test_sub,test_y)
  ######################## end reading files ########################
  ## each df has 561+2 columns, because there are 561 features+"subject"+"activity"

  
  ## merged_df is the merged dataset consisting of only the "desired columns"
  #  (i.e., the columns about means and stds PLUS 562,563, which are subject"+"activity")
  #  Here we call find_indices() to get those columns' indices, where find_indices() is defined later
  
  merged_df <- rbind(train_df[,c(find_indices(),562,563)],test_df[,c(find_indices(),562,563)])
  
  ## Uses descriptive activity names to name the activities in the data set
  merged_df$activity <- descriptive_act_names(merged_df$activity)
  
  ## add descriptive variable names, with the help of revised_variable_names() function, which is defined later
  ## but keep the good variables' names of the last two column unchanged, which are "subject"&"activity"
  names(merged_df)[c(1:(ncol(merged_df)-2))] <- revised_variable_names()
  
  return(merged_df)
}


## my_analysis_2(), for step 5, takes a tidy dataset processed by my_analysis() and
#  creates a second, independent tidy data set with the average of 
#  each variable for each activity and each subject

## the last variable names of merged_df should strictly be "subject" and "activity"
## need library(dplyr)
my_analysis_2 <- function(merged_df){
  
  ## for some issue with "dplyr", I'll use another name for each variable when
  #  manipulating, and change it back later
  
  ## the first "fake loop" initializes the output dataset with 
  #  "subject"&"activity" columns, and
  #  the second "true loop" binds more columns
  for (i in c(1)){
    saved_name <- names(merged_df)[i] # the "true" variable name
    names(merged_df)[i] <- "this_var" # temporary variable name
    result_df <- merged_df  %>% group_by(subject,activity) %>% summarise(mean = mean(this_var))
    names(result_df)[3] <- saved_name # 
    names(merged_df)[i] <- saved_name # change the name back
  } 
  

  for (i in c(2:(length(merged_df)-2))){#for (i in c(1:length(merged_df-2))){
    print(i)
    saved_name <- names(merged_df)[i] # the "true" variable name
    names(merged_df)[i] <- "this_var" # temporary variable name
    this_col_mean <- merged_df  %>% group_by(subject,activity) %>% summarise(mean = mean(this_var))
    names(this_col_mean)[3] <- saved_name
    names(merged_df)[i] <- saved_name # change the name back
    result_df <- cbind(result_df,this_col_mean[3])
  }
  return(result_df)
}
## find_indices tells the index of the features that are about mean & std
find_indices <-function(file = "features.txt"){
  features <- read.delim(file,header = FALSE) # read file and store it in the dataFrame: features
  features_list <- features[,] # break the dataframe to a list so we can call grep()
  m <- grep("[Mm]ean",features_list) # index indicating the features about means
  s <- grep("[Ss]td",features_list)  # index indicating the features about stds
  sort(c(m,s)) # return a sorted list of indices corresponding to desired features 
}




## revised_variable_names extracts the desired variable/features' names
#  (in sorted order) and revises with more descriptive names
revised_variable_names <- function(file = "features.txt"){
  ft_names <- read.table(file,header = FALSE)
  good_indices <- find_indices()
  ft_names <- ft_names[good_indices,2]
  ft_names <- gsub("[Bb]ody[Bb]ody","Body",ft_names) # fixes the typo of having bodybody(perhaps not a bug?)
  ft_names <- gsub("-","_",ft_names) # change "-" to "_" for neatness
  return(ft_names)
}

## takes a vector of activity label in numbers, and return a vector
#  of activity in characters(descriptive names)
descriptive_act_names <- function(act_label){
  result <- rep(0,length(act_label))
  for (i in c(1:length(act_label))){
    result[i] <- switch(act_label[[i]],"WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
    # converted according to the "activity_labels.txt" file
  }
  return(result)
}



################## unused functions, pls ignore them for peer review ##################
## find_mean tells the index of the features that are about means
find_mean <-function(file = "features.txt"){
  features <- read.table(file,header = FALSE) # read file and store it in the dataFrame: features
  features_list <- features[,] # break the dataframe to a list so we can call grep()
  grep("[Mm]ean\\(\\)",features_list, value=TRUE) # index indicating the features about means
}

## find_std tells the index of the features that are about stds
find_std <-function(file = "features.txt"){
  features <- read.table(file,header = FALSE) # read file and store it in the dataFrame: features
  features_list <- features[,] # break the dataframe to a list so we can call grep()
  grep("[Ss]td\\(\\)",features_list,value=TRUE) # index indicating the features about stds
}


