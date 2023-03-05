BEGIN;

DROP TABLE playground.sg_99co_project_transform;

CREATE TABLE playground.sg_99co_project_transform 
AS 

with base as
(
	SELECT 
		project_name,
		bedrooms,
		case when address='None, None' then null else trim(split_part(address, ',', 1)) end as address_road,
		case when address='None, None' then null else trim(split_part(address, ',', 2)) end as postcode,
		district,
		case when showflat_location='-' then null else showflat_location end as showflat_location,
		case when showflat_date='-' then null else to_date(showflat_date,'DD-Mon-YYYY') end as showflat_date_standard,
		case when launch_date='-' then null else to_date(launch_date,'DD-Mon-YYYY') end as launch_datee_standard,
		property_type,
		tenure,
		case when built_year='-' then null else built_year end as built_year,
		case when gross_floor_area='-' then null else replace(trim(split_part(gross_floor_area, 'sqm', 1)),',','')::float end as gross_floor_area_sqm,
		case when gross_floor_area='-' then null when trim(split_part(gross_floor_area, 'sqm', 2))='' then null else replace(replace(trim(split_part(gross_floor_area, 'sqm', 2)),',',''),'sqft','')::float end as gross_floor_area_sqft,
		trim(split_part(blocks,' ', 1))::int as blocks,
		case when units='-' then null else units::int end as units,
		case when floors='-' then null else floors::int end as floors,
		case when carpark_spaces='-' then null else trim(split_part(carpark_spaces,' ', 1))::int end as carpark_spaces,
		developer,
		case when nearest_mrt_station='[]' then null else string_to_array(replace(replace(replace(nearest_mrt_station,'[',''),']',''),'''',''),',') end as nearest_mrt_station_array,
		case when nearest_mrt_time='[]' then null else string_to_array(replace(replace(replace(nearest_mrt_time,'[',''),']',''),'''',''),',') end as nearest_mrt_time_array,
		case when nearest_school='[]' then null else string_to_array(replace(replace(replace(replace(nearest_school,'[',''),']',''),'''',''),'"',''),',') end as nearest_school_array,
		case when nearest_school_time='[]' then null else string_to_array(replace(replace(replace(nearest_school_time,'[',''),']',''),'''',''),',') end as nearest_school_time_array
	FROM  raw_singapore.sg_99co_project scp
),
price_data AS 
(
    SELECT project_name,
           replace(trim(split_part(sale_price, '-', 2)),'S$','') AS highest_tier,
           replace(trim(split_part(sale_price, '-', 1)),'S$','') AS lowest_tier
    FROM raw_singapore.sg_99co_project
),
price_detail AS
(
	SELECT
	    project_name,
	    CASE 
	    	WHEN lowest_tier=''
	        THEN null
	        when lowest_tier LIKE '%K'
	        then split_part(lowest_tier, 'K', 1)::float*1000
	        when lowest_tier LIKE '%M'
	        then split_part(lowest_tier, 'M', 1)::float*1000000
	    END AS sale_price_lowest,
	    CASE 
	    	WHEN highest_tier=''
	        THEN null
	        when highest_tier LIKE '%M'
	        then split_part(highest_tier, 'M', 1)::float*1000000
	    END AS sale_price_highest
	FROM price_data
)
SELECT 
	distinct on (project_name)
	base.*,
	sale_price_lowest,
	sale_price_highest
FROM base
JOIN price_detail USING (project_name)


--GROUP BY base.project_name

COMMIT;


--SELECT count(*) FROM playground.sg_99co_project_transform;
--SELECT count(*) FROM raw_singapore.sg_99co_project;

--SELECT avg(gross_floor_area_sqm) FROM playground.sg_99co_project_transform;
