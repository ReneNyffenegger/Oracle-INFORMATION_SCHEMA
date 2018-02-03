create or replace view information_schema.routines as
  select
    sys_context('userenv', 'DB_NAME')                                                          routine_catalog,
    sys_context('userenv', 'DB_NAME')                                                          specific_catalog,
    ap.owner                                                                                   specific_schema,
    ap.owner                                                                                   routine_schema,
    decode( ap.procedure_name, null, ap.object_name || ap.procedure_name, ap.procedure_name )  specific_name, 
    decode( ap.procedure_name, null, ap.object_name || ap.procedure_name, ap.procedure_name )  routine_name, 
    ao.object_type                                                                             routine_type,
    decode(impltypeowner, null, to_char(null), SYS_CONTEXT('userenv', 'DB_NAME'))              type_udt_catalog,
    to_clob(get_proc_text(ap.owner, ap.object_name, ao.object_type, 32767))                    routine_body,
    to_clob(get_proc_text(ap.owner, ap.object_name, ao.object_type,  4000))                    routine_definition,
    sys_context('userenv', 'DB_NAME')                                                          character_set_catalog,
   'SYS'                                                                                       character_set_schema,
    sys_context('userenv', 'DB_NAME')                                                          collation_catalog,
   'SYS'                                                                                       collation_schema,
    deterministic                                                                              is_deterministic,
    pipelined                                                                                  is_pipelined ,
    aggregate                                                                                  is_aggregate,
    authid                                                                                     is_definer
  from
    all_procedures ap,
    all_objects    ao
  where
    ap.owner       = ao.owner       and
    ap.object_name = ao.object_name and
    ao.object_type in ('PACKAGE', 'PROCEDURE', 'FUNCTION')
;

grant select on routines to public;

create or replace public synonym routines for information_schema.routines;
