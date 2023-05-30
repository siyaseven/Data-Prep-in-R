#############################################
# Preprocessing Data 
#By: Siyabonga Mthiyane
#############################################

# Import library
library("readxl")# reading data from excel
library(readr) # reading data from csv 
library(writexl) # writing to an excel file
library(dplyr) # Data manipulation


#########################################
# 1. Load Data to R working environment
#########################################
#reading the excel files and csv files.
#Due to memory issues in R, meta data was converted to csv and loaded using "readr"
DIR_DATA = '/home/siyabonga/Documents/OneDrive_1_13-05-2023/Data-Prep-in-R'  # main path for meta data storage 
FILENAME_DATA = 'Ali_CTC .csv'
filepath_data <- file.path(DIR_DATA, FILENAME_DATA)
df_ali_ctc <- readr::read_csv(file = filepath_data)


###################################################
#.2 Check the glimpse of data.
###################################################
#Viewing and checking the glimpse of the meta data                     
summary(df_ali_ctc)
head(df_ali_ctc)
tail(df_ali_ctc)
dim(df_ali_ctc)
colnames(df_ali_ctc)
ncol(df_ali_ctc)
nrow(df_ali_ctc)
##########################################################################
#.3 Zeros correspond to missing data. Check how many zeros in each column.
##########################################################################

colSums(df_ali_ctc==0)

#########################################################################
#.4 Check the percentage of Zeros entries in each columns.
# This is checking the % of missing data in the observed data.
##########################################################################

colSums((df_ali_ctc==0)/136690)*100

############################################################################
#.5 If the Percentage of the missing data is >= 90. This is column is an
# outlier. Here we get all the outlier columns and write them to excel file,
############################################################################

possibleOutliers =  data.frame() #creating an empty df to store columns that will be deleted..
DF_to_excel = data.frame() #creating an empty df to store the data to be written to excel.

#checking if missing data is greater than 90%
for (i in 1:ncol(df_ali_ctc))
{
  if ((colSums(df_ali_ctc[,i]==0)/136690)*100 >= 90)
  {
    output = c(colnames(df_ali_ctc[,i], (colSums(df_ali_ctc[,i]==0)/136690)*100))
    possibleOutliers = rbind(possibleOutliers, output)
    C = colnames(df_ali_ctc[,i])
    P = (colSums(df_ali_ctc[,i]==0)/136690)*100
    temp = c(C,P)
    DF_to_excel = rbind(DF_to_excel,temp)

  }
}

possibleOutliers #Checking the df for outliers.

#Renaming the columns before writing data to an excel file.
names(DF_to_excel)[1] <- "Outlier Columns-With lot of Zeros"
names(DF_to_excel)[2] <- "% of missingness"
head(DF_to_excel)

#Writing the outliers into an excel file
write_xlsx(DF_to_excel, 
           "/home/siyabonga/Documents/OneDrive_1_13-05-2023/outliers_from_meta_data.xlsx")


###############################################################################
#.6 Removing all the outlier columns in a dataset.
##############################################################################

df_ali_ctc_copy = df_ali_ctc # Copying data so that we can manipulate the copy.
df_without_out = data.frame() #empty data frame to store meta data without ouliers.

# Removing Outlier columns
for (i in 1:nrow(possibleOutliers))
{
  df_ali_ctc_copy = df_ali_ctc_copy %>% select(-possibleOutliers[i,])
  df_without_out = df_ali_ctc_copy
}

# checkong the glimpse of the data without outlier columns
dim(df_without_out)
head(df_without_out)
tail(df_without_out)

###############################################################################
#.7 Replace all the zero entries in data sets with a random number between 
#1-1000. Data Imputation.
##############################################################################

df_without_out_copy = df_without_out
df_ali_ctc_imput = data_frame()

for (i in 1:ncol(df_without_out))
{
  if (colSums(df_without_out_copy[,i]==0))
  {
    df_without_out_copy[,i] = sample(1:1000, 1) #this code needs to be update.
                                                # the random number should be applied to each entry, not just 
                                                #column.
    df_ali_ctc_imput = df_without_out_copy
  }
}

head(df_ali_ctc_imput)
tail(df_ali_ctc_imput)

