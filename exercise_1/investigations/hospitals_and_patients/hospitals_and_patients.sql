select * from correlate_survey_hospital_score limit 20;
select corr(average_hosp_qual,patient_rate) from correlate_survey_hospital_score;
select corr(hosp_var,patient_rate) from correlate_survey_hospital_score;
select corr(average_hosp_qual,patient_nurses_rate) from correlate_survey_hospital_score;
select corr(hosp_var,patient_nurses_rate) from correlate_survey_hospital_score;
