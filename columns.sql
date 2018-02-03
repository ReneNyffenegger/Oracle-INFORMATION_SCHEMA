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
CREATE OR REPLACE VIEW columns
AS
SELECT * FROM (
    SELECT SYS_CONTEXT('userenv', 'DB_NAME') TABLE_CATALOG,
           owner TABLE_SCHEMA,
           table_name, 
           data_type,
           data_type_mod,
           decode(data_type_owner, null, to_char(null), SYS_CONTEXT('userenv', 'DB_NAME')) domain_catalog,
           data_type_owner domain_schema,
           data_length character_maximum_length,
           data_length character_octet_length,
           data_length,
           data_precision numeric_precision,
           data_scale numeric_scale,
           nullable is_nullable,
           column_id ordinal_position,
           default_length,
           data_default column_default,
           num_distinct,
           low_value,
           high_value,
           density,
           num_nulls,
           num_buckets,
           last_analyzed,
           sample_size,
           SYS_CONTEXT('userenv', 'DB_NAME') character_set_catalog,
           'SYS' character_set_schema,
           SYS_CONTEXT('userenv', 'DB_NAME') collation_catalog,
           'SYS' collation_schema,
           character_set_name,
           char_col_decl_length,
           global_stats,
           user_stats,
           avg_col_len,
           char_length,
           char_used,
           v80_fmt_image,
           data_upgraded,
           histogram
  FROM all_tab_columns av
) columns;
/

grant select on columns to public;

create or replace public synonym columns for information_schema.columns;
