BEGIN;


DROP TABLE playground.sg_ura_rent_transform;

CREATE TABLE playground.sg_ura_rent_transform AS 
SELECT 
	distinct on (building_project_name,street_name,postal_district,type,bedroom_count,monthly_gross_rent,floor_area_sf_min,floor_area_sf_max,lease_commencement_date_standard)
	building_project_name,
	street_name,
	postal_district,
	type,
	case when bedroom_count='na*' then null else bedroom_count::float end as bedroom_count,
	monthly_gross_rent,
	case when replace(trim(split_part(trim(split_part(floor_area_sf, 'to', 1)), '<=', 1)),'>','')='' then null else replace(trim(split_part(trim(split_part(floor_area_sf, 'to', 1)), '<=', 1)),'>','')::int end as floor_area_sf_min,
	case when trim(split_part(floor_area_sf, 'to', 2))='' then null else trim(split_part(floor_area_sf, 'to', 2))::int end as floor_area_sf_max,
	--to_date(lease_commencement_date,'MON-YYYY') as lease_commencement_date_std,
	split_part(lease_commencement_date,'-',2) || '-' || replace(split_part(lease_commencement_date,'-',1),'Apr','04') as lease_commencement_date_standard
from raw_singapore.sg_ura_rent sur 


COMMIT;


select from playground.sg_ura_rent_transform surt
where (surt.building_project_name,surt.street_name) in (select building_project_name,street_name from playground.sg_ura_rent_transform group by building_project_name,street_name having count(*) > 1)



--SELECT count(*) FROM playground.sg_ura_rent_transform;
--SELECT count(*) FROM raw_singapore.sg_ura_rent;

--SELECT avg(gross_floor_area_sqm) FROM pplayground.sg_ura_rent_transform;







