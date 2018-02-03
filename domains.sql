/*
This software has been released under the MIT license:

  Copyright (c) 2009 Lewis R Cunningham

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 
CREATE OR REPLACE VIEW domains
AS
SELECT * FROM (
    SELECT SYS_CONTEXT('userenv', 'DB_NAME') DOMAIN_CATALOG,
           owner domain_SCHEMA,
           type_name domain_name, 
           to_number(null) character_maximum_length, 
           to_number(null) character_octet_length, 
           SYS_CONTEXT('userenv', 'DB_NAME') character_set_catalog,
           'SYS' character_set_schema,
           SYS_CONTEXT('userenv', 'DB_NAME') collation_catalog,
           'SYS' collation_schema,
           SYS_CONTEXT('USERENV','NLS_SORT') COLLATION_NAME, 
           TO_NUMBER(NULL) NUMERIC_PRECISION, 
           TO_NUMBER(NULL) NUMERIC_PRECISION_RADIX, 
           TO_NUMBER(NULL) NUMERIC_SCALE ,
           TO_NUMBER(NULL) DATETIME_PRECISION, 
           TO_CHAR(NULL) DOMAIN_DEFAULT 
  FROM all_types
) domains
/

grant select on domains to public;

create or replace public synonym domains for information_schema.domains;
