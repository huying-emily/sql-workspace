BEGIN;


DROP TABLE playground.realis_project_transform;

CREATE TABLE playground.realis_project_transform
AS 

with base as
(
	SELECT 
		project_name,
		street_name,
		developer,
		total_units_in_project,
		case when written_permission_date='-' then null when EXTRACT(MONTH from(to_timestamp(written_permission_date,'MON-YYYY')))<=9 then EXTRACT(YEAR from(to_timestamp(written_permission_date,'MON-YYYY'))) || '-0' || EXTRACT(MONTH from(to_timestamp(written_permission_date,'MON-YYYY'))) else EXTRACT(YEAR from(to_timestamp(written_permission_date,'MON-YYYY'))) || '-' || EXTRACT(MONTH from(to_timestamp(written_permission_date,'MON-YYYY'))) end as written_permission_date_standard
	from raw_singapore.realis_project rp 
),
type_detail_units_in_project as
(
	select  
		project_name,
		street_name,
		developer,
		total_units_in_project,
		'no_of_detached'||','||no_of_detached||','||'no_of_semi_detached'||','||no_of_semi_detached||','||'no_of_terrace'||','
		||no_of_terrace||','||'no_of_apartments'||','||no_of_apartments||','||'no_of_condominiums'||','||no_of_condominiums||','
		||'no_of_executive_condominiums'||','||no_of_executive_condominiums as units_in_project
	from raw_singapore.realis_project rp
),
type_detail_units_in_project_json as
(
	select  
	project_name,
	street_name,
	developer,
	total_units_in_project,
	json_object(string_to_array(units_in_project,',')) as total_units_in_project_type_detail
	from type_detail_units_in_project
),
status_detail_units_in_project as
(
	select  
		project_name,
		street_name,
		developer,
		total_units_in_project,
		'total_units_by_construction_status_planned'||','||total_units_by_construction_status_planned||','||
		'total_units_by_construction_status_under_construction'||','||total_units_by_construction_status_under_construction||','||
		'total_units_by_construction_status_top'||','||total_units_by_construction_status_top as status_units_in_project
	from raw_singapore.realis_project rp
),
status_detail_units_in_project_json as
(
	select  
	project_name,
	street_name,
	developer,
	total_units_in_project,
	json_object(string_to_array(status_units_in_project,',')) as total_units_in_project_status_detail
	from status_detail_units_in_project
),
pre_requisites_detail_units_in_project as
(
	select  
		project_name,
		street_name,
		developer,
		total_units_in_project,
		'uncompleted_units_without_pre_requisites'||','||uncompleted_units_without_pre_requisites||','||
		'uncompleted_units_with_pre_requisites_total'||','||uncompleted_units_with_pre_requisites_total||','||
		'completed_units_with_pre_requisites_total'||','||completed_units_with_pre_requisites_total as pre_requisites_units_in_project
	from raw_singapore.realis_project rp
),
pre_requisites_detail_units_in_project_json as
(
	select  
	project_name,
	street_name,
	developer,
	total_units_in_project,
	json_object(string_to_array(pre_requisites_units_in_project,',')) as total_units_in_project_pre_requisites_detail
	from pre_requisites_detail_units_in_project
),
uncompleted_detail_units_with_pre_requisites_in_project as
(
	select  
		project_name,
		street_name,
		developer,
		total_units_in_project,
		'uncompleted_units_with_pre_requisites_not_launched'||','||uncompleted_units_with_pre_requisites_not_launched||','||
		'uncompleted_units_with_pre_requisites_launched'||','||uncompleted_units_with_pre_requisites_launched||','||
		'uncompleted_units_with_pre_requisites_sold'||','||uncompleted_units_with_pre_requisites_sold||','||
		'uncompleted_units_with_pre_requisites_launched_but_unsold'||','||uncompleted_units_with_pre_requisites_launched_but_unsold
		as uncompleted_units_with_pre_requisites_in_project
	from raw_singapore.realis_project rp
),
uncompleted_detail_units_with_pre_requisites_in_project_json as
(
	select  
	project_name,
	street_name,
	developer,
	total_units_in_project,
	json_object(string_to_array(uncompleted_units_with_pre_requisites_in_project,',')) as total_uncompleted_units_in_project_with_pre_requisites_detail
	from uncompleted_detail_units_with_pre_requisites_in_project
),
completed_detail_units_with_pre_requisites_in_project as
(
	select  
		project_name,
		street_name,
		developer,
		total_units_in_project,
		'completed_units_with_pre_requisites_completed_and_sold'||','||completed_units_with_pre_requisites_completed_and_sold||','||
		'completed_units_with_pre_requisites_completed_and_unsold'||','||completed_units_with_pre_requisites_completed_and_unsold
		as completed_units_with_pre_requisites_in_project
	from raw_singapore.realis_project rp
),
completed_detail_units_with_pre_requisites_in_project_json as
(
	select  
	project_name,
	street_name,
	developer,
	total_units_in_project,
	json_object(string_to_array(completed_units_with_pre_requisites_in_project,',')) as total_completed_units_in_project_with_pre_requisites_detail
	from completed_detail_units_with_pre_requisites_in_project
)
SELECT 
	distinct on (base.*)
	base.*,
	total_units_in_project_type_detail,
	total_units_in_project_status_detail,
	total_units_in_project_pre_requisites_detail,
	total_uncompleted_units_in_project_with_pre_requisites_detail,
	total_completed_units_in_project_with_pre_requisites_detail
FROM base
left OUTER JOIN type_detail_units_in_project_json USING (project_name,street_name,developer,total_units_in_project)
left OUTER JOIN status_detail_units_in_project_json USING (project_name,street_name,developer,total_units_in_project)
left OUTER JOIN pre_requisites_detail_units_in_project_json USING (project_name,street_name,developer,total_units_in_project)
left OUTER JOIN uncompleted_detail_units_with_pre_requisites_in_project_json USING (project_name,street_name,developer,total_units_in_project)
left OUTER JOIN completed_detail_units_with_pre_requisites_in_project_json USING (project_name,street_name,developer,total_units_in_project)


COMMIT;


