conn sys@&db_name as sysdba

DROP USER information_schema;

CREATE USER information_schema IDENTIFIED BY information_schema;

GRANT CONNECT TO information_schema;
GRANT RESOURCE TO information_schema;
GRANT SELECT_CATALOG_ROLE TO information_schema;
GRANT CREATE PUBLIC SYNONYM TO information_schema;
GRANT SELECT ON props$ TO information_schema WITH GRANT OPTION;
ALTER USER information_schema DEFAULT ROLE CONNECT, RESOURCE, SELECT_CATALOG_ROLE;

connect information_schema@&db_name/information_schema
