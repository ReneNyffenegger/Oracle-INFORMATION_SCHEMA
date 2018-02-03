create or replace view information_schema.catalog_name as
  select sys_context('userenv', 'DB_NAME') catalog_name 
  from dual    
;

grant select on catalog_name to public;

create or replace public synonym catalog_name for information_schema.catalog_name;
