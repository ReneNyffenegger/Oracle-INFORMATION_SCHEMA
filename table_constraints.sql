CREATE OR REPLACE VIEW table_constraints as
select
    SYS_CONTEXT('userenv', 'DB_NAME') constraint_catalog,
    ac.owner                          constraint_schema,
    ac.constraint_name                constraint_name,
    SYS_CONTEXT('userenv', 'DB_NAME') TABLE_CATALOG,
    ac.owner                          TABLE_SCHEMA,
    ac.table_name                     TABLE_NAME,
    case ac.constraint_type
         when 'P' then 'PRIMARY KEY'
         else 'TODO'
    end                               CONSTRAINT_TYPE,
    ac.deferrable                     IS_DEFERRABLE,
    ac.deferred                       INITIALLY_DEFERRED,
    ac.validated                      ENFORCED 
from
    all_constraints ac
;
