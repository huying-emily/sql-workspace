-- Clean up Malaysia Address


--- blank out all address_units
update malaysia.kl_transactions 
set address_unit = null;

--- use regular expressions to look for
--- addresss with 1-2-3 formats
select 
    trim(split_part(address, ',', 1)),
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull ;


select 
    trim(split_part(address, ',', 1)),
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull ;


select 
     trim(split_part(split_part(address, ',', 1), ' ', 1)),
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit =   trim(split_part(split_part(address, ',', 1), ' ', 1))
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull;


update malaysia.kl_transactions kt
set address_unit =   trim(split_part(address, ',', 1))
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull;


select 
    trim(split_part(address, '(', 1)),
     address,
    *
from malaysia.kl_transactions kt 
where trim(split_part(address, '(', 1)) ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]'
and position('(' in split_part(address,',',1)) > 0
and address_unit isnull 


update malaysia.kl_transactions kt
set address_unit =  trim(split_part(address, '(', 1))
where trim(split_part(address, '(', 1)) ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]'
and position('(' in split_part(address,',',1)) > 0
and address_unit isnull 


select 
     trim(split_part(split_part(address, ',', 1), ' ', 1)),
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and position('BLK' in split_part(address,',',1)) = 0
and position('BLOK' in split_part(address,',',1)) = 0
and length(trim(split_part(split_part(address, ',', 1), ' ', 1))) < 10
and address_unit isnull 


select 
     trim(split_part(split_part(address, ',', 1), ' ', 1)),
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and position('BLK' in split_part(address,',',1)) = 0
and position('BLOK' in split_part(address,',',1)) = 0
and length(trim(split_part(split_part(address, ',', 1), ' ', 1))) < 10
and address_unit isnull 


update malaysia.kl_transactions kt
set address_unit =  trim(split_part(split_part(address, ',', 1), ' ', 1))
where address ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and position('BLK' in split_part(address,',',1)) = 0
and position('BLOK' in split_part(address,',',1)) = 0
and length(trim(split_part(split_part(address, ',', 1), ' ', 1))) < 10
and address_unit isnull 


select 
    trim(split_part(address, '(', 1)),
     address,
    *
from malaysia.kl_transactions kt 
where trim(split_part(address, '(', 1)) ~ '^[A-Z0-9]+-[A-Z0-9]+'
and position('(' in split_part(address,',',1)) > 0
and address_unit isnull 


update malaysia.kl_transactions kt
set address_unit =  trim(split_part(address, '(', 1))
where trim(split_part(address, '(', 1)) ~ '^[A-Z0-9]+-[A-Z0-9]+'
and position('(' in split_part(address,',',1)) > 0
and address_unit isnull 


select 
    rtrim(ltrim(trim(split_part(address, ',', 1)),'('),')')
     address,
    *
from malaysia.kl_transactions kt 
where address ~ '^\([A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+\),'
and address_unit isnull 


update malaysia.kl_transactions kt
set address_unit =  rtrim(ltrim(trim(split_part(address, ',', 1)),'('),')')
where address ~ '^\([A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+\),'
and address_unit isnull 


select 
    trim(split_part(address, ',', 1)),
     address,
    *
from malaysia.kl_transactions kt 
where address ~ '^\([A-Z0-9]+-[A-Z0-9]+\),'
and address_unit isnull 


update malaysia.kl_transactions kt
set address_unit =  trim(split_part(address, ',', 1))
where address ~ '^\([A-Z0-9]+-[A-Z0-9]+\),'
and address_unit isnull 


select 
    trim(split_part(address, ',', 1)),
     address,
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+-[A-Z/0-9]+,'
and address_unit isnull 


update malaysia.kl_transactions kt
set address_unit =  trim(split_part(address, ',', 1))
where address ~ '^[A-Z0-9]+-[A-Z/0-9]+,'
and address_unit isnull 


select 
    trim(split_part(address, '.', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where split_part(address, ' ', 1) ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+.'
and position('(' in split_part(address,',',1)) = 0
and position('.' in split_part(address,',',1)) > 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, '.', 1))
where split_part(address, ' ', 1) ~ '^[A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+.'
and position('(' in split_part(address,',',1)) = 0
and position('.' in split_part(address,',',1)) > 0
and address_unit isnull 


select 
    trim(split_part(address, ' ', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where split_part(address, ',', 1) ~ '^[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and position('WEST' in address ) = 0
and position('BLK' in address ) = 0
and position('UPPER' in address ) = 0
and position('TMN' in address ) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit =  trim(split_part(address, ' ', 1))
where split_part(address, ',', 1) ~ '^[A-Z0-9]+-[A-Z0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and position('WEST' in address ) = 0
and position('BLK' in address ) = 0
and position('UPPER' in address ) = 0
and position('TMN' in address ) = 0
and address_unit isnull ;


select 
    trim(split_part(address, ' ', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where split_part(address, ',', 1) ~ '^[A-Z0-9]+-[0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit =  trim(split_part(address, ' ', 1))
where split_part(address, ',', 1) ~ '^[A-Z0-9]+-[0-9]+ '
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

select 
    trim(split_part(address, ',', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+--[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 



update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^[A-Z0-9]+-[A-Z0-9]+--[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 


select 
    trim(split_part(address, ',', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where address ~ '^[A-Z0-9]+--[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^[A-Z0-9]+--[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 


select 
    trim(split_part(address, ',', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where address ~ '^NO [A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^NO [A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

select 
    trim(split_part(address, ',', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where address ~ '^NO. [A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^NO. [A-Z0-9]+-[A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 



select 
    trim(split_part(address, ',', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where address ~ '^NO. [A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 

update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address ~ '^NO. [A-Z0-9]+-[A-Z0-9]+,'
and position('(' in split_part(address,',',1)) = 0
and address_unit isnull 


select 
    trim(split_part(address, ',', 1)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and position('-' in split_part(address, ',', 1) ) > 0


update malaysia.kl_transactions kt
set address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and position('-' in split_part(address, ',', 1) ) > 0


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and position('-' in split_part(address, ',', 1) ) = 0
and position('-' in split_part(address, ',', 2) ) > 0


update malaysia.kl_transactions kt
set 
    address_num = trim(split_part(address, ',', 1)),
    address_unit  =  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and position('-' in split_part(address, ',', 1) ) = 0
and position('-' in split_part(address, ',', 2) ) > 0




select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 2)) like 'JALAN%'


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 2)) like 'JALAN%'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 2)) like 'OFF JALAN%';


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 2)) like 'OFF JALAN%'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 2)) like 'OFF JALAN%'
and trim(split_part(address, ',', 3)) like 'OFF JALAN%'



update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 2)) like 'OFF JALAN%'
and trim(split_part(address, ',', 3)) like 'OFF JALAN%'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 2))  ~ '^[0-9]+$'
and trim(split_part(address, ',', 3)) like 'JALAN%'



update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 2))  ~ '^[0-9]+$'
and trim(split_part(address, ',', 3)) like 'JALAN%'


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 0
and address  ~ '^[0-9]+$'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[0-9]+$'
and trim(split_part(address, ',', 2)) ~ '^[A-Z ]+$'


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[0-9]+$'
and trim(split_part(address, ',', 2)) ~ '^[A-Z ]+$'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[0-9]+[A-Z]$'
and trim(split_part(address, ',', 2)) ~ '^[A-Z ]+$'
and position('BLOK' in trim(split_part(address, ',', 2))) = 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[0-9]+[A-Z]$'
and trim(split_part(address, ',', 2)) ~ '^[A-Z ]+$'
and position('BLOK' in trim(split_part(address, ',', 2))) = 0


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('SEC' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('SEC' in trim(split_part(address, ',', 2))) > 0


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^NO.[A-Z0-9]+$'
and position('BLOK' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^NO.[A-Z0-9]+$'
and position('BLOK' in trim(split_part(address, ',', 2))) > 0



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^NO [A-Z0-9]+$'
and position('BLK' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^NO [A-Z0-9]+$'
and position('BLK' in trim(split_part(address, ',', 2))) > 0


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+\.[A-Z0-9]+$'


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+\.[A-Z0-9]+$'


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('JALAN' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('LORONG' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('PERSIARAN' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('JALAN' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('BL' in trim(split_part(address, ',', 2))) > 0


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 3
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and position('BL' in trim(split_part(address, ',', 2))) > 0



update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+ BL'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^LORONG'


update malaysia.kl_transactions kt
set 
    address_unit = trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^LORONG'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BL'


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BL'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 3
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BK'


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 3
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BK'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^SEKS'



update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^SEKS'


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BBWM'



update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^SEKS'

select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ' ', 1)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+ SEKS'
and trim(split_part(address, ',', 2))  ~ '^BBWM'


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ' ', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+ SEKS'
and trim(split_part(address, ',', 2))  ~ '^BBWM'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ' ', 1)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^UNIT [A-Z0-9]+$'

update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ' ', 1))
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^UNIT [A-Z0-9]+$'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ' ', 1)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^NO [A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^TKT'



update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^NO [A-Z0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^TKT'

select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z.0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^[0-9]+[A-Z]+'

update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z.0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^[0-9]+[A-Z]+'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and position('BLOK' in split_part(address, ',', 1) ) > 0


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and position('BLOK' in split_part(address, ',', 1) ) > 0


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 3
and position('BLOK' in split_part(address, ',', 2) ) > 0


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 3
and position('BLOK' in split_part(address, ',', 2) ) > 0


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^PENTHOUSE [A-Z.0-9]+$'

update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^PENTHOUSE [A-Z.0-9]+$'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z.0-9]+$'


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 1
and trim(split_part(address, ',', 1))  ~ '^[A-Z.0-9]+$'



select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z.0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BBW+'



update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z.0-9]+$'
and trim(split_part(address, ',', 2))  ~ '^BBW+'


select
    trim(split_part(address, ',', 1)),
    trim(split_part(address, ',', 2)),
    trim(split_part(address, ',', 1)) || ' / ' ||  trim(split_part(address, ',', 2))  || ' / ' ||  trim(split_part(address, ',', 3)),
    address ,
    *
from malaysia.kl_transactions kt 
where address_unit isnull 
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+\.[A-Z0-9]+$'


update malaysia.kl_transactions kt
set 
    address_unit =   trim(split_part(address, ',', 1)) 
where address_unit isnull
and property_type in ('SERVICE RESIDENCE', 'CONDOMINIUM', 'FLAT', 'APARTMENT')
and api.text_number_of_characters_in_text(address, ',') = 2
and trim(split_part(address, ',', 1))  ~ '^[A-Z0-9]+\.[A-Z0-9]+$'




--- Starting to populate address num now
---

