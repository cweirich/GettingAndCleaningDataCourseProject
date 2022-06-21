# Codebook

## Codebook for the final assignment of the Getting and Cleaning Data Course

### The data

The data was obtained from *UCI Machine Learning Repository* and was left in its original folder structure.
In the root data folder there's a *README.txt* and a *features_info.txt* files that explain the files and its contents in details.
For the purpose of this project, the necessary files are:

* In the data folder
  * **activity_labels.txt**: contains the labels for all the activities numbered from 1 to 6.
  * **features.txt**: contains the labels for all the variables of the data files, numbered from 1 to 561.

* In the data/train and data/test folders
  * **subject_train.txt** and **subject_test.txt**: contain the subject, numbered from 1 to 30.
  * **X_train.txt** and **X_test.txt**: contain all 561 variables described in *features.txt*.
  * **y_train.txt** and **y_test.txt**: contain all activities performed by the subjects, as described in *activity_labels.txt*.

### The dependencies

Packages *dplyr* and *reshape2* must be installed before running the script

### The variables and transformations

The script uses the *mountTable* function to do most of the job, fulfilling the requirements 2-4 of the assignment.
The function receives one parameter that defines if it should do the work for the "test" or "train" datasets.
Given the parameter, it navigates the data directories, reads the data files and create datasets for:
* Subjects
* Activities
* Measurements

And join those three datasets to create a single table that is returned.

Note that these tables have:
* Only the measurements on the mean and standard deviation (req. 2)
* Descriptive activity names (req. 3)
* Descriptive variable names (req. 4).

So we have the following environment variables:
1. **testTable**: returned by *mountTable* with "test" parameter.
2. **trainTable**: returned by *mountTable* with "train" parameter.
3. **wholeDataset**: the merge of the test and train datasets (req. 1)
4. **moltenDataset**: the long format of the dataset, using the columns subject and activity as constants.
5. **tidyDataset**: the reshaped molten data using the mean of the activities, grouped by subject and activity (req. 5)
