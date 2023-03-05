BEGIN;

FOR var_c IN
		SELECT c.column_name，c.table_name FROM information_schema.columns c WHERE c.table_schema = 'datamart'
	LOOP 
		EXECUTE'SELECT'|| var_c || 'group by'|| var_c; 
	END LOOP; 

END; 





select (
(select count({{ key }}) from {{ base_table }}
inner join {{ join_table }} using ({{ key }}))
/ (select count(*) from {{ check_table }}))

intersect

select(select count(

select dw_address_id from view_building vb 
intersect select dw_address_id from star_building sb 
--771,052

select dw_address_id from star_building vb 
intersect select dw_address_id from view_building sb
--771,052


select(round(
(select count(*) from (select dw_address_id from datamart.star_building
intersect select dw_address_id from datamart.ref_full_building))
/(select count(*) from datamart.star_building)::numeric, 6))
--982/953491 => 0.103%




select(round(
(select count(*) from (select dw_building_id from datamart.star_building
intersect select dw_building_id from datamart.ref_full_building))
/(select count(*) from datamart.star_building)::numeric, 6))
--0


---------------------------------------------------------------------------------

--address

select 
'star_address' as star_table, 'ref_full_address' as ref_table,'dw_address_id' as merge_column,
(round((select count(*) from (select dw_address_id from datamart.star_address
intersect select dw_address_id from datamart.ref_full_address))
/(select count(*) from datamart.star_address)::numeric, 6)) as merge_percentage

union

select 
'star_building' as star_table, 'ref_full_building' as ref_table,'dw_building_id' as merge_column,
(round((select count(*) from (select dw_building_id from datamart.star_building
intersect select dw_building_id from datamart.ref_full_building))
/(select count(*) from datamart.star_building)::numeric, 6)) as merge_percentage

union

select 
'star_project' as star_table, 'ref_full_project' as ref_table,'dw_project_id' as merge_column,
(round((select count(*) from (select dw_project_id from datamart.star_project
intersect select dw_project_id from datamart.ref_full_project))
/(select count(*) from datamart.star_project)::numeric, 6)) as merge_percentage

union

select 
'star_property' as star_table, 'ref_full_property' as ref_table,'dw_property_id' as merge_column,
(round((select count(*) from (select dw_property_id from datamart.star_property
intersect select dw_property_id from datamart.ref_full_property))
/(select count(*) from datamart.star_property)::numeric, 6)) as merge_percentage

---------------------------------------------------------





select 'star_address'                                                          as star_table,
       'ref_full_address'                                                      as ref_table,
       'dw_address_id'                                                         as merge_column,
       (round((select count(*)
               from (select distinct dw_address_id
                     from datamart.star_address
                     WHERE country = 'sg'
                     intersect
                     select distinct dw_address_id
                     from datamart.ref_full_address
                     WHERE country = 'sg'))
                  / (select count(*) from datamart.star_address WHERE country = 'sg')::numeric, 6)) as merge_percentage

union

select 'star_building'                                                          as star_table,
       'ref_full_building'                                                      as ref_table,
       'dw_building_id'                                                         as merge_column,
       (round((select count(*)
               from (select dw_building_id
                     from datamart.star_building
					 WHERE country = 'sg'
                     intersect
                     select dw_building_id
                     from datamart.ref_full_building WHERE country = 'sg'))
                  / (select count(*) from datamart.star_building WHERE country = 'sg')::numeric, 6)) as merge_percentage

union

select 'star_project'                                                          as star_table,
       'ref_full_project'                                                      as ref_table,
       'dw_project_id'                                                         as merge_column,
       (round((select count(*)
               from (select dw_project_id
                     from datamart.star_project
					 WHERE country = 'sg'
                     intersect
                     select dw_project_id
                     from datamart.ref_full_project WHERE country = 'sg'))
                  / (select count(*) from datamart.star_project WHERE country = 'sg')::numeric, 6)) as merge_percentage

union

select 'star_property'                                                          as star_table,
       'ref_full_property'                                                      as ref_table,
       'dw_property_id'                                                         as merge_column,
       (round((select count(*)
               from (select dw_property_id
                     from datamart.star_property
					 WHERE country = 'sg'
                     intersect
                     select dw_property_id
                     from datamart.ref_full_property WHERE country = 'sg' ))
                  / (select count(*) from datamart.star_property WHERE country = 'sg')::numeric, 6)) as merge_percentage;


                 
                 

----address
select 'star_address'                                                          as star_table,
       'ref_full_address'                                                      as ref_table,
       'address_num'                                                         as merge_column,
       (round((select count(*)
       from (select address_num
             from datamart.star_address
             WHERE country = 'sg'
             intersect
             select address_num
             from datamart.ref_full_address
             WHERE country = 'sg'))
          / (select count(*) from datamart.star_address WHERE country = 'sg')::numeric, 6)) as merge_percentage


union 


select distinct address_num
             from datamart.star_address
             WHERE country = 'sg'

select distinct address_num
             from datamart.ref_full_address
             WHERE country = 'sg'



select round((WITH base AS (
    SELECT postal_code
    FROM datamart.star_address
    WHERE country = 'sg'
    GROUP BY 1

    INTERSECT

    SELECT postal_code
    FROM datamart.ref_full_address
    WHERE country = 'sg'
    GROUP BY 1
)
SELECT COUNT(*)
FROM base)
/
(SELECT COUNT(DISTINCT postal_code)
FROM datamart.star_address
WHERE country = 'sg')::numeric, 6) as match_rate


select (round((select count(*)
               from (select dw_property_id
                     from datamart.star_property
					 WHERE country = 'sg'
                     intersect
                     select dw_property_id
                     from datamart.ref_full_property WHERE country = 'sg' ))
                  / (select count(*) from datamart.star_property WHERE country = 'sg')::numeric, 6))




select 'star_address'       as star_table,
       'ref_full_address'   as ref_table,
       'postal_code'      as merge_column,
       round((with base as (select postal_code from datamart.star_address where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate
union
select 'star_address'       as star_table,
       'ref_full_address'   as ref_table,
       'address_num'      as merge_column,
       round((with base as (select address_num from datamart.star_address where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate
union
select 'star_address'       as star_table,
       'ref_full_address'   as ref_table,
       'address_street'      as merge_column,
       round((with base as (select address_street from datamart.star_address where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate


select 'star_building'       as star_table,
       'ref_full_building'   as ref_table,
       'building_name'      as merge_column,
       round((with base as (select building_name from datamart.star_building where country = 'sg' group by 1
                            intersect
                            select building_name from datamart.ref_full_building where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct building_name) from datamart.star_building where country = 'sg')::numeric, 6) as match_rate

select 'star_building'       as star_table,
       'ref_full_building'   as ref_table,
       'building_type'      as merge_column,
       round((with base as (select building_type from datamart.star_building where country = 'sg' group by 1
                            intersect
                            select building_type from datamart.ref_full_building where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct building_type) from datamart.star_building where country = 'sg')::numeric, 6) as match_rate

select 'star_building'       as star_table,
       'ref_full_building'   as ref_table,
       'dw_address_id'      as merge_column,
       round((with base as (select dw_address_id from datamart.star_building where country = 'sg' group by 1
                            intersect
                            select dw_address_id from datamart.ref_full_building where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct dw_address_id) from datamart.star_building where country = 'sg')::numeric, 6) as match_rate


select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'address_street'      as merge_column,
       round((with base as (select address_street from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'address_num'      as merge_column,
       round((with base as (select address_num from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'zip'      as merge_column,
       round((with base as (select zip from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct zip) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'country'      as merge_column,
       round((with base as (select country from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select country from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct country) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'dw_address_id key columns'      as merge_column,
       round((with base as (select address_street, address_num, zip from datamart.ref_full_building where country = 'sg' group by 1, 2, 3
                            intersect
                            select address_street, address_num,postal_code from datamart.star_address where country = 'sg' group by 1, 2, 3)
                            select count(*) from base)
            /(with base as (select address_street, address_num, zip from datamart.ref_full_building where country = 'sg' group by 1, 2, 3)
                            select count(*) from base)::numeric, 6) as match_rate

select 'star_project'       as star_table,
       'ref_full_project'   as ref_table,
       'project_name'      as merge_column,
       round((with base as (select project_name from datamart.star_project where country = 'sg' group by 1
                            intersect
                            select project_name from datamart.ref_full_project where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct project_name) from datamart.star_project where country = 'sg')::numeric, 6) as match_rate

select 'star_project'       as star_table,
       'ref_full_project'   as ref_table,
       'developer'      as merge_column,
       round((with base as (select developer from datamart.star_project where country = 'sg' group by 1
                            intersect
                            select developer from datamart.ref_full_project where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct developer) from datamart.star_project where country = 'sg')::numeric, 6) as match_rate

select 'star_project'       as star_table,
       'ref_full_project'   as ref_table,
       'num_of_units'      as merge_column,
       round((with base as (select num_of_units from datamart.star_project where country = 'sg' group by 1
                            intersect
                            select num_of_units from datamart.ref_full_project where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct num_of_units) from datamart.star_project where country = 'sg')::numeric, 6) as match_rate

select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'address_stack'      as merge_column,
       round((with base as (select address_stack from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select stack from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_stack) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate

select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'address_floor'      as merge_column,
       round((with base as (select address_floor from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select floor_text from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_floor) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate

select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'dw_building_id'      as merge_column,
       round((with base as (select dw_building_id from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select dw_building_id from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct dw_building_id) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_property'       as star_table,
       'ref_full_property'   as ref_table,
       'dw_address_id'      as merge_column,
       round((with base as (select dw_address_id from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select dw_address_id from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct dw_address_id) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_property'       as star_table,
       'star_address'   as ref_table,
       'street'      as merge_column,
       round((with base as (select street from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct street) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate


select 'ref_full_property'       as star_table,
       'star_address'   as ref_table,
       'blkno'      as merge_column,
       round((with base as (select blkno from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct blkno) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_property'       as star_table,
       'star_address'   as ref_table,
       'postal_code'      as merge_column,
       round((with base as (select postal_code from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate
union
select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'property_type'      as merge_column,
       round((with base as (select property_type from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select buildingclass from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct property_type) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate









--address
select 'star_address'       as star_table,
       'ref_full_address'   as ref_table,
       'postal_code'      as merge_column,
       round((with base as (select postal_code from datamart.star_address where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate
union
select 'star_address'       as star_table,
       'ref_full_address'   as ref_table,
       'address_num'      as merge_column,
       round((with base as (select address_num from datamart.star_address where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate
union
select 'star_address'       as star_table,
       'ref_full_address'   as ref_table,
       'address_street'      as merge_column,
       round((with base as (select address_street from datamart.star_address where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate

union
--building
select 'star_building'       as star_table,
       'ref_full_building'   as ref_table,
       'dw_address_id'      as merge_column,
       round((with base as (select dw_address_id from datamart.star_building where country = 'sg' group by 1
                            intersect
                            select dw_address_id from datamart.ref_full_building where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct dw_address_id) from datamart.star_building where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'address_street'      as merge_column,
       round((with base as (select address_street from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'address_num'      as merge_column,
       round((with base as (select address_num from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'zip'      as merge_column,
       round((with base as (select zip from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct zip) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_building'       as star_table,
       'star_address'   as ref_table,
       'address_street, address_num, zip'      as merge_column,
        round((with base as (select address_street, address_num, zip from datamart.ref_full_building where country = 'sg' group by 1, 2, 3
                            intersect
                            select address_street, address_num,postal_code from datamart.star_address where country = 'sg' group by 1, 2, 3)
                            select count(*) from base)
            /(with base as (select address_street, address_num, zip from datamart.ref_full_building where country = 'sg' group by 1, 2, 3)
                            select count(*) from base)::numeric, 6) as match_rate
union
select 'star_building'       as star_table,
       'ref_full_building'   as ref_table,
       'building_name'      as merge_column,
       round((with base as (select building_name from datamart.star_building where country = 'sg' group by 1
                            intersect
                            select building_name from datamart.ref_full_building where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct building_name) from datamart.star_building where country = 'sg')::numeric, 6) as match_rate

union
--project
select 'star_project'       as star_table,
       'ref_full_project'   as ref_table,
       'project_name'      as merge_column,
       round((with base as (select project_name from datamart.star_project where country = 'sg' group by 1
                            intersect
                            select project_name from datamart.ref_full_project where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct project_name) from datamart.star_project where country = 'sg')::numeric, 6) as match_rate
union
select 'star_project'       as star_table,
       'ref_full_project'   as ref_table,
       'developer'      as merge_column,
       round((with base as (select developer from datamart.star_project where country = 'sg' group by 1
                            intersect
                            select developer from datamart.ref_full_project where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct developer) from datamart.star_project where country = 'sg')::numeric, 6) as match_rate

union
--property
select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'address_stack'      as merge_column,
       round((with base as (select address_stack from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select stack from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_stack) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate
union
select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'address_floor'      as merge_column,
       round((with base as (select address_floor from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select floor_text from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_floor) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate
union
select 'star_property'       as star_table,
       'ref_full_property'   as ref_table,
       'dw_address_id'      as merge_column,
       round((with base as (select dw_address_id from datamart.star_property where country = 'sg' group by 1
                            intersect
                            select dw_address_id from datamart.ref_full_property where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct dw_address_id) from datamart.star_property where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_property'       as star_table,
       'star_address'   as ref_table,
       'street'      as merge_column,
       round((with base as (select street from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct street) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_property'       as star_table,
       'star_address'   as ref_table,
       'blkno'      as merge_column,
       round((with base as (select blkno from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct blkno) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate
union
select 'ref_full_property'       as star_table,
       'star_address'   as ref_table,
       'postal_code'      as merge_column,
       round((with base as (select postal_code from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate





select 'star_address'       as star_table,
       'ref_full_building'   as ref_table,
       'address_street'      as merge_column,
       round((with base as (select address_street from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_address'       as star_table,
       'ref_full_building'   as ref_table,
       'address_street'      as merge_column,
       round((with base as (select address_street from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.ref_full_address where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_address'       as star_table,
       'ref_full_building'   as ref_table,
       'address_num'      as merge_column,
       round((with base as (select address_num from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.ref_full_address where country = 'sg')::numeric, 6) as match_rate

select 'star_address'       as star_table,
       'ref_full_building'   as ref_table,
       'zip'      as merge_column,
       round((with base as (select zip from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_address'       as star_table,
       'ref_full_building'   as ref_table,
       'zip'      as merge_column,
       round((with base as (select zip from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.ref_full_address where country = 'sg')::numeric, 6) as match_rate


select 'star_address'       as star_table,
       'ref_full_building'   as ref_table,
       'address_street, address_num, postal_code'      as merge_column,
        round((with base as (select address_street, address_num, zip from datamart.ref_full_building where country = 'sg' group by 1, 2, 3
                            intersect
                            select address_street, address_num,postal_code from datamart.star_address where country = 'sg' group by 1, 2, 3)
                            select count(*) from base)
            /(with base as (select address_street, address_num, postal_code from datamart.star_address where country = 'sg' group by 1, 2, 3)
                            select count(*) from base)::numeric, 6) as match_rate

select 'star_address'       as star_table,
       'ref_full_property'   as ref_table,
       'street'      as merge_column,
       round((with base as (select street from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate


select 'ref_full_address'       as star_table,
       'ref_full_property'   as ref_table,
       'street'      as merge_column,
       round((with base as (select street from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.ref_full_address where country = 'sg')::numeric, 6) as match_rate


select 'star_address'       as star_table,
       'ref_full_property'   as ref_table,
       'blkno'      as merge_column,
       round((with base as (select blkno from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate


select 'star_address'       as star_table,
       'ref_full_property'   as ref_table,
       'postal_code'      as merge_column,
       round((with base as (select postal_code from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.star_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct postal_code) from datamart.star_address where country = 'sg')::numeric, 6) as match_rate




select 'ref_full_building'       as star_table,
       'ref_full_address'   as ref_table,
       'address_street'      as merge_column,
       (with base as (select address_street from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_street) from datamart.ref_full_building where country = 'sg') as match_rate

select 'ref_full_building'       as star_table,
       'ref_full_address'   as ref_table,
       'address_num'      as merge_column,
       round((with base as (select address_num from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select address_num from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct address_num) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_building'       as star_table,
       'ref_full_address'   as ref_table,
       'postal_code'      as merge_column,
       round((with base as (select zip from datamart.ref_full_building where country = 'sg' group by 1
                            intersect
                            select postal_code from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct zip) from datamart.ref_full_building where country = 'sg')::numeric, 6) as match_rate

select 'ref_full_property'       as star_table,
       'ref_full_address'   as ref_table,
       'street'      as merge_column,
       round((with base as (select street from datamart.ref_full_property where country = 'sg' group by 1
                            intersect
                            select address_street from datamart.ref_full_address where country = 'sg' group by 1)
                            select count(*) from base)
            /(select count(distinct street) from datamart.ref_full_property where country = 'sg')::numeric, 6) as match_rate





















            
            
            
  
