# Getting and cleaning data


For creating a tidy data set of wearable computing data collected from the accelerometers from the Samsung Galaxy S smartphone

## Files in this repo
* README.md -- explains how all of the scripts work and how they are connected
* CodeBook.md -- describs variables, the data and transformations
* run_analysis.R -- actual R code for performing the analysis

## run_analysis.R walkthrough
It follows the goals step by step.

* Step 1:
  * Read all the test and training files into R
  * Combine the files to a data frame in the form of subjects, labels, the rest of the data

* Step 2:
  * Read the features from features.txt 
  * Select features with mean and standard deviation
  * Created a new data with subjects, labels and selected features

* Step 3:
  * Read the activity labels from activity_labels.txt
  * Replacing numeric labels of activity with actual activity names

* Step 4:
  * Get a list of the current column names and feature names
  * Clean the colname of data_mean_std with gsub order
  
* Step 5:
  * Create a new data frame by finding the mean for each combination of subject and label
  
* Final step:
  * Write the new tidy set into a text file called final_data.txt
