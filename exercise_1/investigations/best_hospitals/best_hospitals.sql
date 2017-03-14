
drop table overall_hospital_procedures;

create table overall_hospital_procedures
as
select
provider_id,
hospital_name,
avg(percentage_score_hosp) as overall_score_hosp
from hospitals_with_info left join  hospitals_vs_all on hwi = provider_id
group by provider_id, hospital_name
order by overall_score_hosp DESC
;

select * from overall_hospital_procedures limit 10;
