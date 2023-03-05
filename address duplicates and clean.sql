--duplicates
select * from singapore.project p 
where project_name in (select project_name from singapore.project group by project_name having count(project_name) > 1)
order by project_name,  developer 

DELETE from singapore.project 
where project_name in (select project_name from singapore.project group by project_name having count(project_name) > 1)
AND developer isnull

--clean address
select address_uuid,
	address_full_text ,
	address_local_text ,
	address_num ||' '|| address_street ,
	replace(address_local_text,SUBSTRING(address_local_text,position(address_building in address_local_text),50),''),
	address_building ,
	address_display_text,
	replace(address_local_text,SUBSTRING(address_local_text,position(address_building in address_local_text),50),'')||'- '||address_building
from singapore.address a
where position(address_building  in address_local_text ) > 0

update singapore.address a
set address_local_text = replace(address_local_text,SUBSTRING(address_local_text,position(address_building in address_local_text),50),''),
	address_display_text = replace(address_local_text,SUBSTRING(address_local_text,position(address_building in address_local_text),50),'')||'- '||address_building
where position(address_building  in address_local_text ) > 0
and api.text_number_of_characters_in_text(replace(address_local_text,SUBSTRING(address_local_text,position(address_building in address_local_text),50),''),' ') > 1

update singapore.address a
set address_display_text = address_local_text||'- '||address_building
where position(address_building  in address_local_text ) > 0
and api.text_number_of_characters_in_text(replace(address_local_text,SUBSTRING(address_local_text,position(address_building in address_local_text),50),''),' ') <= 1


------

select
    address_uuid,
    address_num || ' ' || address_street,
    address_full_text,
    address_building ,
    substring(address_full_text, 0, length(address_num || ' ' || address_street)+1),
    INITCAP (address_num || ' ' || address_street || '-' || address_building)
from singapore.address a
where address_num || ' ' || address_street <> substring(address_full_text, 0, length(address_num || ' ' || address_street)+1)
and address_street <> 'NIL'

update singapore.address a
set address_local_text = address_num || ' ' || address_street,
	address_display_text = INITCAP(address_num || ' ' || address_street || '-' || address_building)
where address_num || ' ' || address_street = substring(address_full_text, 0, length(address_num || ' ' || address_street)+1)

update singapore.address a
set address_local_text = substring(address_full_text, 0, length(address_num || ' ' || address_street)+1),
	address_display_text = INITCAP(substring(address_full_text, 0, length(address_num || ' ' || address_street)+1) || '-' || address_building)
where address_num || ' ' || address_street <> substring(address_full_text, 0, length(address_num || ' ' || address_street)+1)
and address_street <> 'NIL'

--update singapore.address a
--set address_local_text = address_num,
--	address_display_text = address_num || '-' || address_building
--where address_num || ' ' || address_street <> substring(address_full_text, 0, length(address_num || ' ' || address_street)+1)
--and address_street = 'NIL'

select
	address_local_text ,
    address_full_text,
    address_building ,
    address_display_text
from singapore.address a
where api.get_number_of_characters_in_text(address_display_text,'-')=0


update singapore.address a
set address_display_text = INITCAP(address_display_text)
where api.get_number_of_characters_in_text(address_display_text,'-')=0


select address_uuid,
address_local_text ,
address_full_text ,
address_building ,
address_display_text
from singapore.address a
where position(address_building  in address_local_text ) > 0

