# Getting and Cleaning Data: Course Project

The R script, `run_analysis.R` does the following steps:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidy.txt`.

## Files in Repository
1. `README.md`: Explanation about the repository and Code.
2. `Run_analysis.R`: Code in R
3. `CookBook.md`: Variables in the dataset
4. `Tidy.txt`: Dataset 
