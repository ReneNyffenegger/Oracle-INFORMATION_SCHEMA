create or replace view information_schema.triggers as
  select
    sys_context('userenv', 'DB_NAME') trigger_catalog,
    at.owner                          trigger_schema,
    at.trigger_name                   trigger_name,
    null event_manipulation,
    null event_object_catalog,
    null event_object_schema,
    null event_object_table,
    null action_order,
    null ACTION_CONDITION, -- CASE WHEN EXISTS               ( SELECT * FROM DEFINITION_SCHEMA.SCHEMATA AS S WHERE ( TRIGGER_CATALOG, TRIGGER_SCHEMA )                     = ( S.CATALOG_NAME, S.SCHEMA_NAME ) AND                       ( S.SCHEMA_OWNER = CURRENT_USER OR                         S.SCHEMA_OWNER IN                         ( SELECT ROLE_NAME FROM ENABLED_ROLES ) ) ) THEN ACTION_CONDITION ELSE NULL END AS ACTION_CONDITION,
    null ACTION_STATEMENT, -- CASE WHEN EXISTS               ( SELECT * FROM DEFINITION_SCHEMA.SCHEMATA AS S WHERE ( TRIGGER_CATALOG, TRIGGER_SCHEMA )                     = ( S.CATALOG_NAME, S.SCHEMA_NAME ) AND                       ( S.SCHEMA_OWNER = CURRENT_USER OR                         S.SCHEMA_OWNER IN                         ( SELECT ROLE_NAME FROM ENABLED_ROLES ) ) ) THEN ACTION_STATEMENT ELSE NULL END AS ACTION_STATEMENT,
    null action_orientation,
    null action_timing,
    null action_reference_old_table,
    null action_reference_new_table,
    null action_reference_old_row,
    null action_reference_new_row,
    null created
  from
    all_triggers at join
    all_objects  ao on at.owner        = ao.owner and
                       at.trigger_name = ao.object_name
;
grant select on triggers to public;

create or replace public synonym triggers for information_schema.routines;
