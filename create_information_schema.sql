-- conn sys@&db_name as sysdba
connect / as sysdba

-- Rene Nyffenegger, 2018-02-03: drop … CASCADE.
drop user information_schema cascade;

create user information_schema identified by information_schema;

grant connect               to information_schema;
grant create view           to information_schema /* Rene Nyffenegger, 2018-02-03 */;
grant resource              to information_schema;
grant select_catalog_role   to information_schema;
grant create public synonym to information_schema;
grant select on props$      to information_schema with grant option;

-- Rene Nyffenegger, 2018-02-03
grant select on sys.all_procedures to information_schema with grant option;
grant select on sys.all_tables     to information_schema with grant option;
grant select on sys.all_types      to information_schema with grant option;
grant select on sys.all_users      to information_schema with grant option;
grant select on sys.all_views      to information_schema with grant option;

alter user information_schema default role connect, resource, select_catalog_role;

-- connect information_schema@&db_name/information_schema
   connect information_schema/information_schema
