#!/bin/bash

# save my current directory
MY_CWD=$(pwd)

# empty and remove staging directories
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging

#remove files from hdfs
hdfs dfs -rm /user/w205/hospital_compare/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/surveys_responses.csv
hdfs dfs -rm /user/w205/hospital_compare/Measures.csv
hdfs dfs -rm /user/w205/hospital_compare/readmissions.csv

# removeour hdfs directory
hdfs dfs -rmdir /user/w205/hospital_compare

#change directory back to original
cd $MY_CWD

# clean exit
exit

