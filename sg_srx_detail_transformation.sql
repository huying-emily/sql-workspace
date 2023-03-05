BEGIN;


DROP TABLE playground.sg_srx_detail_transform;

CREATE TABLE playground.sg_srx_detail_transform AS 

SELECT 
	distinct on (property_name,location)
	listing_title,
	property_name,
	property_type,
	replace(block_num,'Blk ','') as block_num,
	replace(replace(asking,'$',''),',','')::int as asking_price,
	replace(replace(psf,'$',''),' psf','')::float as psf_price,
	built_year,
	developer,
	trim(split_part(trim(split_part(address,'(', 1)),' ', 1)) as address_road_no,
	trim(split_part(address,'(', 1)) as address_road,
	trim(split_part(trim(split_part(address,'(', 2)),')', 1)) as postcode,
	hdb_town,
	trim(split_part(district,'-', 1)) as district_no,
	trim(split_part(district,'-', 2)) as district_name,
	case when bedroom='Studio' then 0 when bedroom like '%+%' then trim(split_part(bedroom,'+', 1))::int+trim(split_part(bedroom,'+', 2))::int else bedroom::int end as bedroom_num,
	bathroom::int,
	furnish,
	case when area not like '%sqm%' then null else trim(replace(replace(area,' sqm (Built-up)',''),',',''))::int end as area_land_sqm,
	case when area not like '%/%' then null else replace(replace(trim(split_part(area, '/', 1)),' sqft (Land)',''),',','')::int end as area_land_sqft,
	case when area like '%sqm%' then null when area not like '%/%' then trim(replace(replace(area,' sqft (Built-up)',''),',',''))::int  else replace(replace(trim(split_part(area, '/', 2)),' sqft (Built-up)',''),',','')::int end as area_built_up_sqft,
	replace(tenure,'LEASEHOLD/','') as tenure,
	num_of_unit::int,
	replace(replace(replace(facility,'[',''),']',''),'''','') as facility,
	location,
	trim(split_part(agent,'(', 1)) as agent_name,
	agent_contact,
	case when near_mrt='[]' then null else string_to_array(replace(replace(replace(replace(near_mrt,'[',''),']',''),'''',''),'"',''),',') end as near_mrt_array,
	case when near_bus_stop='[]' then null else string_to_array(replace(replace(replace(replace(near_bus_stop,'[',''),']',''),'''',''),'"',''),',') end as near_bus_stop_array,
	case when near_primary_school='[]' then null else string_to_array(replace(replace(replace(replace(near_primary_school,'[',''),']',''),'''',''),'"',''),',') end as near_primary_school_array,
	case when near_secondry_school='[]' then null else string_to_array(replace(replace(replace(replace(near_secondry_school,'[',''),']',''),'''',''),'"',''),',') end as near_secondry_school_array,
	case when near_integrate_school='[]' then null else string_to_array(replace(replace(replace(replace(near_integrate_school,'[',''),']',''),'''',''),'"',''),',') end as near_integrate_school_array,
	case when near_shopping_mall='[]' then null else string_to_array(replace(replace(replace(replace(near_shopping_mall,'[',''),']',''),'''',''),'"',''),',') end as near_shopping_mall_array,
	case when near_grocery='[]' then null else string_to_array(replace(replace(replace(replace(near_grocery,'[',''),']',''),'''',''),'"',''),',') end as near_grocery_array
from raw_singapore.sg_srx_sale_detail sssd 


COMMIT;
