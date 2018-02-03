create or replace view information_schema.schemata as
-- SELECT * FROM (
with char_set as (
  select
    value$ cs
  from
    sys.props$ 
   where
    name = 'NLS_CHARACTERSET'
)
select
  sys_context('userenv', 'DB_NAME')      catalog_name, 
  username                               schema_name, 
  char_set.cs                            default_character_set_name,     
  sys_context('USERENV','NLS_SORT')      default_collation_name, 
  to_char(null)                          sql_path
from
  char_set,
  all_users
-- ) schemata
/

grant select on schemata to public;

create or replace public synonym schemata for information_schema.schemata;
