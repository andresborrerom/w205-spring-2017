#!/bin/bash

# save my current directory
MY_CWD=$(pwd)

# creating staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1


#change to staging directory
cd ~/staging/exercise_1

# get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget "$MY_URL" -O medicare_data.zip

#unzip the medicare data
unzip medicare_data.zip

# create our hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective
hdfs dfs -mkdir /user/w205/hospital_compare/surveys
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions


# remove the first line of files and rename
OLD_FILE="Hospital General Information.csv"
NEW_FILE="hospitals.csv"
TECH="Timely and Effective Care - Hospital.csv"



tail -n +2 "$OLD_FILE" >$NEW_FILE
tail -n +2 "$TECH" >effective_care.csv 
tail -n +2 "hvbp_hcahps_11_10_2016.csv" >surveys_responses.csv
tail -n +2 "Measure Dates.csv" >Measures.csv 
tail -n +2 "Readmissions and Deaths - Hospital.csv" >readmissions.csv
 



# copy the files to hdfs

hdfs dfs -put $NEW_FILE /user/w205/hospital_compare/hospitals
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys
hdfs dfs -put Measures.csv /user/w205/hospital_compare/measures
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions



#change directory back to original

cd $MY_CWD

# clean exit

exit


