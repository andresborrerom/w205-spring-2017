
drop table overall_state_procedures;

create table overall_state_procedures
as
select
state,
avg(percentage_score) as overall_score
from state_vs_all
group by state
order by overall_score DESC
;

select * from overall_state_procedures limit 10;
