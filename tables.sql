create or replace view information_schema.tables as
-- select * from (
  select
    sys_context('userenv', 'DB_NAME')       table_catalog, 
    owner                                   table_schema,
    table_name                              table_name,
    case 
    when iot_type  = 'Y' then 'IOT'
    when temporary = 'Y' then 'TEMP'
    else                      'BASE TABLE'
    end                                     table_type         
  from 
    all_tables
union all
 select
    sys_context('userenv', 'DB_NAME')       table_catalog,
    owner                                   table_schema,
    view_name                               table_name, 
   'VIEW'                                   table_type
from
  all_views    
-- ) tables
;

grant select on tables to public;

create or replace public synonym tables for information_schema.tables;
