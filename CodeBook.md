# Getting and Cleaning Data

### Preface
The raw dataset contains two kinds of data - *training data* and *test data*. The structure of both datasets are the same, with the training set occupying 31.5 MB space on disk and the test set occupying 12.67 MB on disk.
There are *30* subjects whose data is taken into account. For each row in the table, the subjectId from subject_xxx.txt. 

### Feature List
The datasets is a table of readings from 561 features, named V1 to V561. The names of these are found in features.txt, or in the data frame *featureList*.
Features have the following data with them:
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.
For this assignment, only the *mean()* and *sd()* are taken into account

### Cleaning
1. Change the column names of the training and test datasets using featureList
2. The Row ID of the dataset is found in subject_xxx.txt, or testSubjects and trainingSubjects in the script. Merge them using rbind to get 10299 observations
3. Add Activity Name from activityList. Bind it to the table from Step 2
4. Merge the raw training set and the raw test set using rbind to get 10299 observations
5. Add the Row ID column to the beginning of the merged set from Step 3 to get a complete dataset. The final dimension of the dataSet is 10299 x 562.
6. Sort the dataSet based on Subject ID

## Computing
1. Subset the dataSet with constraint as column name containing "mean" or "sd"
2. Summarise the data using lapply. lapply mean() and .SD for the data
3. Write the resulting data into a text file