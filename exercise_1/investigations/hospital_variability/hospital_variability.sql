
drop table hospitals_procedure_variability;
create table hospitals_procedure_variability
as 
select 
condition,
measure_name,
stddev_pop(percentage_score_hosp) as variability
from hospitals_vs_all
group by condition, measure_name
order by variability DESC
;

select * from hospitals_procedure_variability limit 10;
