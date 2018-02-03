create or replace view information_schema.domains as
--select * from (
select
  sys_context('USERENV', 'DB_NAME') domain_catalog,
  owner                             domain_schema,
  type_name                         domain_name, 
  to_number(null)                   character_maximum_length, 
  to_number(null)                   character_octet_length, 
  sys_context('USERENV', 'DB_NAME') character_set_catalog,
 'SYS'                              character_set_schema,
  sys_context('USERENV', 'DB_NAME') collation_catalog,
 'SYS'                              collation_schema,
  sys_context('USERENV','NLS_SORT') collation_name, 
  to_number(null)                   numeric_precision, 
  to_number(null)                   numeric_precision_radix, 
  to_number(null)                   numeric_scale ,
  to_number(null)                   datetime_precision, 
  to_char  (null)                   domain_default 
from
  all_types
--) domains
;

grant select on domains to public;

create or replace public synonym domains for information_schema.domains;
