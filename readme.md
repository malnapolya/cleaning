The code aims to provide a data table according to the instructions of the Project for the Getting and Cleaning Data Course
The script should be located in the same directory where the "features.txt", "activity_labels.txt" are located along
with the directories "train" and "test".
The script first reads all the data, binds the test and train data separately, then binds the two datasets together
After renaming the columns referring to the measured data using the features data set and renaming the 
first two columns (Subject and Activity), it selects only those columns that contain mean or std and creates a new table 
from here. 
The mean and std include all the data that have "mean()" and "std()" or "meanFreq" because these are the ones that provide
real mean or standard deviation data according to any kind of "meaning"/std principle.
After this, it merges the table with the Activity labels, substituting the Activity numbers with the label names, then 
reorders the table by ascending subject and activity.
Finally, a new table with the average value to every unique Subject and Activity combination is created, and the function
returns this table, along with writing an "output.txt" file which contains the same table.
	
	