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
CREATE OR REPLACE VIEW schemata 
AS
SELECT * FROM (
  WITH char_set AS (
    SELECT value$ cs
      FROM sys.props$ 
      WHERE name = 'NLS_CHARACTERSET')
  SELECT SYS_CONTEXT('userenv', 'DB_NAME') CATALOG_NAME, 
         USERname SCHEMA_NAME, 
         char_set.cs DEFAULT_CHARACTER_SET_NAME,     
         SYS_CONTEXT('USERENV','NLS_SORT') DEFAULT_COLLATION_NAME, 
         TO_CHAR(NULL) SQL_PATH
    FROM char_set,
         all_users
) schemata
/

grant select on schemata to public;

create or replace public synonym schemata for information_schema.schemata;
