

--- Start with the raw data filesm
select * from raw_import.sg_sla_cadastral_land_parcel



update raw_import.sg_sla_cadastral_land_parcel 
set lot_key = split_part(split_part(land_lot_desc , '<th>LOT_KEY</th> <td>', 2), '</td>', 1),
    inc_crc = split_part(split_part(land_lot_desc , '<th>INC_CRC</th> <td>', 2), '</td>', 1),
    fmel_upd_d = split_part(split_part(land_lot_desc , '<th>FMEL_UPD_D</th> <td>', 2), '</td>', 1),
    load_id = nextval('raw_import.load_id_seq')


update raw_import.sg_sla_master_plan_2019_land_use 
set 
    land_use_desc = split_part(split_part(land_lot_desc , '<th>LU_DESC</th> <td>', 2), '</td>', 1),
    land_use_text = split_part(split_part(land_lot_desc , '<th>LU_TEXT</th> <td>', 2), '</td>', 1),
    gross_plan_ratio = split_part(split_part(land_lot_desc , '<th>GPR</th> <td>', 2), '</td>', 1),
    whi_q_mx = split_part(split_part(land_lot_desc , '<th>WHI_Q_MX</th> <td>', 2), '</td>', 1),
    gross_plot_ratio_b_mn = split_part(split_part(land_lot_desc , '<th>GPR_B_MN</th> <td>', 2), '</td>', 1),
    inc_crc = split_part(split_part(land_lot_desc , '<th>INC_CRC</th> <td>', 2), '</td>', 1),
    fmel_upd_d = split_part(split_part(land_lot_desc , '<th>FMEL_UPD_D</th> <td>', 2), '</td>', 1),
    load_id = nextval('raw_import.load_id_seq')
    
    
--- need to merge the land use with the land parcel






--- the information in the land parcel is duplicated

create table qa.sg_sla_cadastral_land_parcel
as 
select distinct on (lot_key) 
    fmel_upd_d,
    load_id, 
        land_lot_name, lot_key, inc_crc, 
        split_part(lot_key, '-', 1) as survey_district,
        split_part(lot_key, '-', 2) as lot_no,
        geom
    from raw_import.sg_sla_cadastral_land_parcel ssclp 
order by 
    lot_key, 
    fmel_upd_d desc



--- because populating the land lots is expensive with st_contains
--- we need to split it up -- as much as possible


create table production_v3.sg_sla_planning_region
as
select 
    PA.region_n as planning_region,
    st_union(PA.geom) as geom
from production_v3.sg_sla_planning_area PA
group by region_n;




update production_v3.sg_sla_cadastral_land_parcel L
set planning_region = M.planning_region 
from production_v3.sg_sla_planning_region M
where  st_contains(M.geom, L.geom)
and L.planning_region isnull;


--- if you check after this is done there are about
--- 510 land lots that do not have planning regions
--- these could be "roads" that cross between regions
--- or other lots that are in between


update production_v3.sg_sla_cadastral_land_parcel L
set planning_area = pa.pln_area_n 
from production_v3.sg_sla_planning_area PA
where st_contains(PA.geom, L.geom)
and PA.region_n = L.planning_region;


--- if you check after this is done there are about
--- 2023 land lots that do not have planning areas


---- any way this updates the subzones
update production_v3.sg_sla_cadastral_land_parcel L
set subzone = Z.subzone_id 
from production_v3.sg_sla_sub_zones Z
where st_contains(Z.geom, L.geom)
and Z.planning_area = L.planning_area 
and L.subzone isnull;



--- explain fix addresses
update production_v3.sg_onemap_address A
set planning_region = R.planning_region 
from production_v3.sg_sla_planning_region R
where st_contains(R.geom, A.geom) 


update production_v3.sg_onemap_address A
set planning_area = PA.planning_area 
from production_v3.sg_sla_planning_area PA
where st_contains(PA.geom, A.geom) 
and A.planning_region = PA.planning_region;


update production_v3.sg_onemap_address A
set subzone_id =  L.subzone_id 
from production_v3.sg_sla_sub_zones L
where st_contains(L.geom, A.geom) 
and A.planning_area = L.planning_area;




----- with the address and land lots matched by area 
---- we can try to 

update production_v3.sg_onemap_address A
set land_lot_key =  L.lot_key 
from production_v3.sg_sla_cadastral_land_parcel L
where st_contains(L.geom, A.geom) 
and A.subzone_id = L.subzone;



--- after wards can try to update using full list
update production_v3.sg_onemap_address A
set land_lot_key =  L.lot_key 
from production_v3.sg_sla_cadastral_land_parcel L
where st_contains(L.geom, A.geom)
and A.land_lot_key isnull 
and A.planning_region = L.planning_region 


update production_v3.sg_onemap_address A
set land_lot_key =  L.lot_key 
from production_v3.sg_sla_cadastral_land_parcel L
where st_contains(L.geom, A.geom)
and A.land_lot_key isnull 


--- at teh end there are a few that do not match --- need to review



--- the above land lots also need to be matched with the land use tables


update raw_import.sg_sla_master_plan_2019_land_use L
set planning_region = M.planning_region 
from production_v3.sg_sla_planning_region M
where  st_contains(M.geom, L.geom)
and L.planning_region isnull;


update raw_import.sg_sla_master_plan_2019_land_use L
set planning_area = pa.planning_area 
from production_v3.sg_sla_planning_area PA
where st_contains(PA.geom, L.geom)
and PA.planning_region = L.planning_region;


update raw_import.sg_sla_master_plan_2019_land_use L
set subzone = Z.subzone_id 
from production_v3.sg_sla_sub_zones Z
where st_contains(Z.geom, L.geom)
and Z.planning_area = L.planning_area 
and L.subzone isnull;


--- ths sql takes about 8mins to run but will complete
update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where U.planning_region = P.planning_region 
and P.land_use_id isnull 
and U.planning_area = P.planning_area 
and U.subzone = P.subzone
and ST_Contains(U.geom, ST_PointOnSurface(P.geom))



update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where U.planning_region = P.planning_region 
and U.planning_area = P.planning_area 
and P.land_use_id isnull 
and ST_Contains(U.geom, ST_PointOnSurface(P.geom))


update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where U.planning_region = P.planning_region 
and P.land_use_id isnull 
and ST_Contains(U.geom, ST_PointOnSurface(P.geom))


update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where U.planning_region = P.planning_region 
and P.land_use_id isnull 
and U.planning_area = P.planning_area 
and U.subzone = P.subzone
and ST_Contains(U.geom, ST_CENTROID(P.geom))


update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where U.planning_region = P.planning_region 
and P.land_use_id isnull 
and U.planning_area = P.planning_area 
and ST_Contains(U.geom, ST_CENTROID(P.geom))


update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where U.planning_region = P.planning_region 
and P.land_use_id isnull 
and ST_Contains(U.geom, ST_CENTROID(P.geom))



update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where P.land_use_id isnull 
and p.planning_region isnull 
and ST_Contains(U.geom, ST_PointOnSurface(P.geom))



update production_v3.sg_sla_cadastral_land_parcel P
set land_use_id = U.load_id 
from raw_import.sg_sla_master_plan_2019_land_use U
where P.land_use_id isnull 
and ST_Contains(U.geom, ST_PointOnSurface(P.geom))



---- Update land use info
update production_v3.sg_sla_cadastral_land_parcel P
set land_use = U.land_use_desc ,
    gross_plot_ratio = U.gross_plan_ratio 
from raw_import.sg_sla_master_plan_2019_land_use U 
where P.gross_plot_ratio isnull 
and P.land_use_id = U.load_id 





