#############################################
# Preprocessing Data 
#By: Siyabonga Mthiyane
#############################################

# Import library
library("readxl") #reading data from excel
library(readr) #reading data from csv
library(xlsx) # writing to an excel file
#reading the excel files and csv files.
df_outliers = read_excel("/home/siyabonga/Documents/OneDrive_1_13-05-2023/possible outliers.xlsx",
                         sheet = 'Outliers')

#Due to memory issues in R raw data was converted to csv and loaded using "readr"
DIR_DATA = '/home/siyabonga/Documents/OneDrive_1_13-05-2023'  # main path for raw data storage 
FILENAME_DATA = 'Ali_CTC .csv'
filepath_data <- file.path(DIR_DATA, FILENAME_DATA)
df_ali_ctc <- readr::read_csv(file = filepath_data)

#Viewing and checking the glimpse of the possible outliers data  
head(df_outliers)
tail(df_outliers)
dim(df_outliers)
colnames(df_outliers)

#Viewing and checking the glimpse of the raw data                     
summary(df_ali_ctc)
head(df_ali_ctc)
tail(df_ali_ctc)
dim(df_ali_ctc)
colnames(df_ali_ctc)

#Removing NAs in outliers data
df_outliers_no_na = na.omit(df_outliers)

# Deleting rows with outliers from the raw data
df_outliers_no_na$`New name`
#adding .txt in colnames of outliers to be compared to colnames of raw data
for (ColNames in df_outliers_no_na$`New name`)
{
  df_outliers_no_na$`New name`= paste0(ColNames,".txt") #string comcatinating
}

df_outliers_no_na$`New name` #these colnames are the same as the one in raw data

# Checking if the colnmanes exist in the raw data

for (ColNames in df_outliers_no_na$`New name`)
{
  if (ColNames %in% colnames(df_ali_ctc))
  {
    print(ColNames)
   # write.xlsx(ColNames, file = "/home/siyabonga/Documents/OneDrive_1_13-05-2023/existing_outliers.xlsx",
               #sheetName = "exit_outlier", append = FALSE)
  }
  else
  {
    print("This does not exist")
    #write.xlsx(ColNames, file = "/home/siyabonga/Documents/OneDrive_1_13-05-2023/existing_outliers.xlsx",
               #sheetName = "no_outlier", append = FALSE)
  }
}

#deleting the outliers columns in raw data


# Removing Zero entries

# Extracting Plate Date from the file numbers

# Extracting Cell type from file numbers

# Questions Regarding data?
# How do we determine possible outliers?
# What do the values mean in the data?
# 


