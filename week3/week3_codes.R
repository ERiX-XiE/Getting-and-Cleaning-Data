# set.seed(13435)
# 
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),];X$var2[c(1,3)] = NA
# 
# X[,1] # 1st column
# 
# X[,"var1"] # speficy the column by name
# X[1:2,"var2"] # trivial
# 
# X[(X$var1 <= 3 & X$var3 > 11),] # specify which rows u want
# 
# X[(X$var1 <= 3|X$var3 > 15),]

##########################################

## using which 
X[which(X$var2 > 8),]

## sort 
sort(X$var1)
sort(X$var1,decreasing = TRUE)
sort(X$var1,na.last = TRUE) # put all the NA at the end of the sort

## ordering
X[order(X$var1),]

##########################################

## ordering with plyr

# library(plyr)
# plyr::arrange(X,var1) # don't miss plyr:: # 
# 
# plyr::arrange(X, desc(var1)) # put in descending order

## Getting the data from the web
# if(!file.exists("./data")){dir.create("./data")}
# fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
# download.file(fileUrl, destfile="./data/restaurants.csv",method = "curl")
# restData <- read.csv("./data/restaurants.csv")

## make table
# table(restData$zipCode, useNA="ifany")


yesno <- sample(c("yes","no"),size = 10, replace=TRUE)
yesnofac = factor(yesno, levels = c("yes","no"))
relevel(yesnofac, ref = "yes")