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
CREATE OR REPLACE VIEW views 
AS
SELECT * FROM (
    SELECT SYS_CONTEXT('userenv', 'DB_NAME') TABLE_CATALOG,
           owner TABLE_SCHEMA,
           view_name table_name, 
           text view_definition,
           'VIEW' table_type,
           (select max(
                   case
                   when uuc.updatable = 'YES'
                     or uuc.deletable = 'YES'
                     or uuc.insertable = 'YES'
                   then
                     'YES'
                   else
                     'NO'
                   end )
              from USER_UPDATABLE_COLUMNS uuc
              where uuc.owner = av.owner
                and uuc.table_name = av.view_name) is_updatable,
            decode((select 1
               from all_constraints ac
               where ac.owner = av.owner
                 and ac.table_name = AV.VIEW_NAME
                 and AC.CONSTRAINT_TYPE = 'V'), 1, 'CASCADE', 'NONE') check_option 
    FROM all_views av
) views;
/

grant select on views to public;

create or replace public synonym views for information_schema.views;
