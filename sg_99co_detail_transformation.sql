BEGIN;

DROP TABLE playground.sg_99co_detail_transform;

CREATE TABLE playground.sg_99co_detail_transform as

with base as
(
	select
		distinct *
	from raw_singapore.sg_99co sc
)
select
	--distinct on(property_name, description, amenities, agent_name, psf)
	property_name,
	case when address like '%District%' then property_name||','||replace(address,', Singapore','') else replace(address,', Singapore','') end as address_adjusted,
	case when address like '%HDB%' or address like '%District%' then 1 else 0 end as is_hdb,
	case when price like '%M' then replace(replace(price,'S$',''),'M','')::float*1000000 else replace(replace(price,'S$',''),',','')::int end as price,
	replace(replace(bedroom,' Beds',''),' Bed','') as bedroom,
	replace(replace(bathroom,' Baths',''),' Bath','')::int as bathroom,
	replace(trim(split_part(sqft,' ',1)),',','')::int as sqft_built_up,
	trim(split_part(replace(replace(psf,'S$',''),',',''),' ',1))::float as psf,
	furnishing,
	case when availability !='Now' then to_date(availability,'DD-Mon-YYYY')::text else availability end as availability_date,
	lease,
	district,
	facing,
	pets,
	keys_on_hand,
	ethnic,
	to_date(property_tenancy_lease_expiry,'DD-Mon-YYYY')::text as property_tenancy_lease_expiry_date,
	replace(property_tenancy_current_rent,'S$','')::int as property_tenancy_current_rent,
	property_floor,
	string_to_array(replace(replace(replace(amenities,'[',''),']',''),'''',''),',') as amenities_array,
	agent_name,
	agent_company,
	description,
	case when total_units like '%None%' then null else trim(split_part(total_units,':',2))::int end as total_units,
	case when year_of_completion like '%:%' then trim(split_part(year_of_completion,':',2)) else year_of_completion end as year_of_completion,
	case when tenure like '%-' then null when tenure like '%:%' then trim(split_part(tenure,':',2)) else tenure end as tenure
from base 
--group by property_name,description


