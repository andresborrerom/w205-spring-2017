#!/bin/bash

# save my current directory
MY_CWD=$(pwd)

# empty and remove staging directories
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging

#remove files from hdfs
hdfs dfs -rm /user/w205/hospital_compare/hospitals/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/surveys/surveys_responses.csv
hdfs dfs -rm /user/w205/hospital_compare/measures/Measures.csv
hdfs dfs -rm /user/w205/hospital_compare/readmissions/readmissions.csv

# removeour hdfs directory
hdfs dfs -rmdir /user/w205/hospital_compare/hospitals
hdfs dfs -rmdir /user/w205/hospital_compare/effective
hdfs dfs -rmdir /user/w205/hospital_compare/surveys
hdfs dfs -rmdir /user/w205/hospital_compare/measures
hdfs dfs -rmdir /user/w205/hospital_compare/readmissions
hdfs dfs -rmdir /user/w205/hospital_compare


#change directory back to original
cd $MY_CWD

# clean exit
exit

