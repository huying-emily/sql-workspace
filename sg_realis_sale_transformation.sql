BEGIN;


DROP TABLE playground.realis_sale_transform;

CREATE TABLE playground.realis_sale_transform AS 

SELECT 
	distinct on (project_name,address_road,address_unit_no,area)
	project_name,
	trim(split_part(address,' ',1)) as address_road_no,
	trim(split_part(trim(split_part(address,'#',1)),trim(split_part(address,' ',1)),2)) as address_road,
	trim(split_part(address,'#',2)) as address_unit_no,
	address,
	no_of_units,
	area,
	type_of_area,
	transacted_price,
	case when nett_price='-' then null else nett_price end as nett_price,
	unit_price_psm,
	unit_price_psf,
	to_date(sale_date,'DD-Mon-YYYY') as sale_date_standard,
	property_type,
	case when tenure='Freehold' then tenure else replace(trim(split_part(tenure,'From',1)),'Yrs','years') end as tenure,
	case when tenure='Freehold' then null else trim(split_part(tenure,'From',2)) end as tenure_start_time,
	completion_date,
	type_of_sale,
	case when purchaser_address_indicator='N.A' then null else purchaser_address_indicator end as purchaser_address_indicator,
	postal_district,
	postal_sector,
	postal_code,
	planning_region,
	planning_area
from raw_singapore.realis_sale rs 


COMMIT;

SELECT * from playground.realis_sale_transform order by project_name,address_unit_no 

