
drop table care_numscore;
create table care_numscore
as 
select
provider_id,
hospital_name, 
state,
condition,
measure_name,
score + 0 as score_num
from care
where score != 'Not Available'
;

drop table state_procedure_avg_score;
create table state_procedure_avg_score
as 
select 
state,
condition,
measure_name,
avg(score_num) as state_procedure_measure_avg
from care_numscore
where score_num is not null
group by state, condition, measure_name
;



drop table max_min_proc_measure;
create table max_min_proc_measure
as 
select 
condition,
measure_name,
max(state_procedure_measure_avg) as max_proc_measure,
min(state_procedure_measure_avg) as min_proc_measure
from state_procedure_avg_score
group by condition, measure_name
;


drop table state_procedure_avg_score;
create table state_procedure_avg_score
as 
select 
state,
condition as procedure,
measure_name as mn,
avg(score_num) as state_procedure_measure_avg
from care_numscore
where score_num is not null
group by state, condition, measure_name
;



drop table state_vs_all;
create table state_vs_all
as 
select 
state,
condition,
measure_name,
state_procedure_measure_avg,
max_proc_measure,
min_proc_measure,
((1 -(max_proc_measure - state_procedure_measure_avg)/(max_proc_measure - min_proc_measure)) * 100) as percentage_score
from max_min_proc_measure join state_procedure_avg_score
on condition = procedure and  measure_name = mn
;


drop table max_min_proc_measure_hospitals;
create table max_min_proc_measure_hospitals
as 
select 
condition as cond,
measure_name as mn,
max(score_num) as max_proc_measure_all,
min(score_num) as min_proc_measure_all
from care_numscore
where score_num is not null
group by condition, measure_name
;


drop table hospitals_vs_all;
create table hospitals_vs_all
as 
select 
provider_id,
hospital_name,
score_num,
condition,
measure_name,
max_proc_measure_all,
min_proc_measure_all,
((1 -(max_proc_measure_all - score_num)/(max_proc_measure_all - min_proc_measure_all)) * 100) as percentage_score_hosp
from care_numscore join max_min_proc_measure_hospitals on condition = cond and measure_name = mn
where score_num is not null
;





drop table hospitals_with_info;

create table hospitals_with_info
as
select
provider_id as hwi
from care_numscore
group by provider_id
having count(*) > 10
;




drop table hosp_for_corr;

create table hosp_for_corr
as
select
provider_id,
stddev_pop(percentage_score_hosp) as hosp_var,
avg(percentage_score_hosp) as average_hosp_qual
from hospitals_vs_all right join hospitals_with_info on provider_id = hwi
group by provider_id
;




drop table correlate_survey_hospital_score;

create table correlate_survey_hospital_score
as 
select
hosp_var,
average_hosp_qual,
(overall_rating_of_hospital_performance_rate + 0) as patient_rate,
(communication_with_nurses_performance_rate +0) as patient_nurses_rate
from hosp_for_corr inner join survey_responses on provider_id = provider_number
;



































