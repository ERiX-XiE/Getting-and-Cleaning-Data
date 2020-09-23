# ERiX XIE

# if(!file.exists("./data")){dir.create("./data")}
# fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
# download.file(fileUrl, destfile="./data/cameras.csv", method = "curl")
# cameraData <- read.csv("./data/cameras.csv")
# names(cameraData)
# 
# tolower(names(cameraData)) # to lowercase
# 
# splitNames = strsplit(names(cameraData),"\\.")
# splitNames[[5]]
# splitNames[[6]]
# myList <- list(letters = c("A","b","c"), numbers = 1:3, matrix(1:25, ncol=5))

# 
# fistElement <- function(x) {x[1]} # define a function
# sapply(splitNames, fistElement)

################### Working with Dates ################### 

d1 = date() # class is "characters"
d2 = Sys.Date() # class is "date"
ymd("20140108") 
mdy("08/04/2022")
dmy("03-04-2013")
################### Dealing with Times ################### 


ymd_hms("2011-02-02 10:11:11")
?Sys.timezone