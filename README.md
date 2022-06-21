# GettingAndCleaningDataCourseProject

This is the final assignment of the Getting and Cleaning Data Course.

This repo contains:

* A run_analysis script, with commentaries explaining what it does
* A codebook explaining in details the variables and procedures of the script
* A 'data' folder containing the data downloaded from UCI Machine Learning Repository

The data folder is exactly as is when unzipped, with the exception of the 'Inertial Signals' folders, which are not necessary and were removed to save space. Note that the script uses this structure to read the files, so it must not be changed.

To run the script, just open this project in RStudio and source the run_analysis.R file.
It will create some variables in RStudio's environment and write a 'tidydataset.txt' file in the working directory.

For more details please read the codebook.