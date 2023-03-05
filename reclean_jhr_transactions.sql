select distinct property_type, count(*) from processing_my.jhr_transactions group by property_type order by count;
--num. of 'BUNGALOW TOWN', 'BUNGALOW TERRACE', 'SEMI-D TERRACE' small, search if necessary change to 'BUNGALOW', 'SEMI-D' 

select 
    project_display_name ,
    tenure_text ,
    property_type ,
	address,
    address_num ,
    address_street ,
    address_unit ,
    address_block ,
    floor_text ,
    stack ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('BUNGALOW TOWN', 'BUNGALOW TERRACE', 'SEMI-D TERRACE')

--1
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(stack , ' ', 2)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (address ~ 'PTD' or address ~ 'PTB' or address ~ 'LOT')

--2
select 
    address,
    address_num ,
    address_street ,
    trim(split_part(address_unit , '-', 1)),
    trim(split_part(address_unit , '-', 3)),
    trim(split_part(address_unit , '-', 2)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_unit ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+'
and address_block isnull 

--3
select 
    address,
    address_num ,
    address_street ,
    trim(split_part(trim(split_part(address , ',', 1)), ' ', 3)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (address ~ 'BLK' or address ~ 'BLOK' or address ~ 'BLOCK' or address ~ 'DSA')
and address_block isnull 

select 
    address,
    address_num ,
    address_street ,
    trim(split_part(trim(split_part(address , ',', 2)), ' ', 2)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (address ~ 'BLK' or address ~ 'BLOK' or address ~ 'BLOCK' or address ~ 'DSA')
and address_block isnull 

select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (address ~ 'BLK' or address ~ 'BLOK' or address ~ 'BLOCK' or address ~ 'DSA')
and address_block isnull 

--4
select 
    address,
    address_num ,
    address_street ,
    trim(split_part(address_block , ' ', 2))||''||trim(split_part(address_block , ' ', 3)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (address_block ~ 'BLK' or address_block ~ 'BLOK' or address_block ~ 'BLOCK' or address_block ~ 'DSA')

update processing_my.jhr_transactions jt
set 
    address_block = trim(split_part(address_block , ' ', 2))||''||trim(split_part(address_block , ' ', 3))
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (address_block ~ 'BLK' or address_block ~ 'BLOK' or address_block ~ 'BLOCK' or address_block ~ 'DSA')


--5
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and floor_text = stack 

--6
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and floor_text ~'^[0-9]+[0-9]+[0-9]+[0-9]'


select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and floor_text ~'^[0-9]+[0-9]+[0-9]'

select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~'^[0-9]+[0-9]+[0-9]+[0-9]+[0-9]'


select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~'^[0-9]+[0-9]+[0-9]'


select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(stack , '(', 1)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(stack , '(') = 1

update processing_my.jhr_transactions jt
set 
    stack = trim(split_part(stack , '(', 1))
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(stack , '(') = 1

--7
select 
    address,
    address_num ,
    address_street ,
    trim(split_part(trim(split_part(address, ',', 1)), '-', 2)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and floor_text notnull
and stack isnull 

--8
select 
    address,
    address_num ,
    address_street ,
    trim(split_part(trim(split_part(trim(split_part(address, ',', 1)), '-', 1)),'#',2)),
    trim(split_part(trim(split_part(address, ',', 1)), '-', 2)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_unit ~'^#[0-9]+-[0-9]'

--9
select 
    address,
    address_num ,
    address_street ,
    trim(split_part(address, ',', 3)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_street isnull 

--10
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(stack , ' ', 2)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~ 'NO' 
and trim(split_part(stack , ' ', 2)) != ''

update processing_my.jhr_transactions jt
set 
    stack = trim(split_part(stack , ' ', 2))
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~ 'NO' 
and trim(split_part(stack , ' ', 2)) != ''

select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(stack , '.', 2)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~ 'NO.' 

update processing_my.jhr_transactions jt
set 
    stack = trim(split_part(stack , '.', 2))
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~ 'NO.' 


select 
    address,
    address_num ,
    address_street ,
    trim(split_part(trim(split_part(address_unit , ',', 1)), ' ', 2)),
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (stack ~ 'BLK' or stack ~ 'BLOK' or stack ~ 'BLOCK' or stack ~ 'DSA' or stack ~ 'NO')


select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(stack , '(', 1)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and stack ~ '(PUA)' 

select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(stack , ' ', 2)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and (stack ~ 'UNIT' or stack ~ 'LOT')

--11
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    trim(split_part(trim(split_part(address_unit , '-', 1)), '#', 2)),
    trim(split_part(address_unit , '-', 2)),
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address ~ 'UNIT' 
and (stack='' or stack isnull )

--12
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block isnull 
and floor_text isnull 
and stack isnull 


--13
select 
    address,
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2))||','||trim(split_part(address, ',', 3)),
    address_num ,
    address_street ,
    *
from processing_my.jhr_transactions jt 
where property_type not in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_street isnull 


select 
    address,
    trim(split_part(address, ',', 1)),
    address_num ,
    address_street ,
    *
from processing_my.jhr_transactions jt 
where property_type not in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(address, ',') = 1
and api.get_number_of_characters_in_text(address, '-') = 0
and api.get_number_of_characters_in_text(address, '/') = 0
and api.get_number_of_characters_in_text(address, '#') = 0
and address_num isnull 

--14
update processing_my.jhr_transactions jt
set 
    address_num = NULL
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')

select 
    address,
    trim(split_part(address, ',', 1)),
    address_num ,
    address_street ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(address, ',') = 1
and api.get_number_of_characters_in_text(address, '-') = 0
and api.get_number_of_characters_in_text(address, '/') = 0
and api.get_number_of_characters_in_text(address, '#') = 0
and api.get_number_of_characters_in_text(address, 'BLOK') = 0
and api.get_number_of_characters_in_text(address, 'BLOCK') = 0
and api.get_number_of_characters_in_text(address, 'BLK') = 0
and api.get_number_of_characters_in_text(address, '(') = 0
and api.get_number_of_characters_in_text(address, 'UNIT') = 0
and api.get_number_of_characters_in_text(address, 'LEVEL') = 0
and api.get_number_of_characters_in_text(address, 'TINGKAT') = 0
and api.get_number_of_characters_in_text(address, 'TKT') = 0
and address_num isnull 

update processing_my.jhr_transactions jt
set 
    address_num = trim(split_part(address, ',', 1))
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(address, ',') = 1
and api.get_number_of_characters_in_text(address, '-') = 0
and api.get_number_of_characters_in_text(address, '/') = 0
and api.get_number_of_characters_in_text(address, '#') = 0
and api.get_number_of_characters_in_text(address, 'BLOK') = 0
and api.get_number_of_characters_in_text(address, 'BLOCK') = 0
and api.get_number_of_characters_in_text(address, 'BLK') = 0
and api.get_number_of_characters_in_text(address, '(') = 0
and api.get_number_of_characters_in_text(address, 'UNIT') = 0
and api.get_number_of_characters_in_text(address, 'LEVEL') = 0
and api.get_number_of_characters_in_text(address, 'TINGKAT') = 0
and api.get_number_of_characters_in_text(address, 'TKT') = 0
and address_num isnull 


--15
select 
    address,
    trim(split_part(address_num , '(', 1)),
    address_num ,
    address_street ,
    *
from processing_my.jhr_transactions jt 
where property_type not in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(address_num , '(') > 0

update processing_my.jhr_transactions jt
set 
    address_num = trim(split_part(address_num , '(', 1))
where property_type not in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.get_number_of_characters_in_text(address_num , '(') > 0

--16
update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'PV','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'PV'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'PMT','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'PMT'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'NO.','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'NO.'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'NO','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'NO'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'BK','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'BK'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'BLK','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'BLK'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'BLOK','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'BL0K'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'BLOCK','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'BL0CK'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'ASOKA','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'ASOKA'

update processing_my.jhr_transactions jt 
set address_block = replace (address_block ,'AKASIA','')
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and address_block ~'AKASIA'

--17
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and floor_text notnull 
and address_block is null 





--CHECK
select 
    address,
    address_num ,
    address_street ,
    address_block ,
    floor_text ,
    stack ,
    address_unit ,
    *
from processing_my.jhr_transactions jt 
where property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')


select 
    address,
    address_num ,
    address_street ,
    *
from processing_my.jhr_transactions jt 
where property_type not in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')