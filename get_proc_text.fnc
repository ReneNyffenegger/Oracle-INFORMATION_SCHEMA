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
CREATE OR REPLACE FUNCTION get_proc_text(
  p_owner IN VARCHAR2,
  p_name IN VARCHAR2,
  p_type IN VARCHAR2,
  p_size IN PLS_INTEGER DEFAULT 32767 ) 
RETURN CLOB
AS
  v_text CLOB;
  v_max_size PLS_INTEGER;
  v_size PLS_INTEGER := 0;
  v_size_running PLS_INTEGER := 0;
BEGIN
 
  IF p_size IS NULL
  OR p_size < 0
  --OR p_size > 32767
  THEN v_max_size := 32767;
  ELSE v_max_size := p_size;
  END IF;
   
  FOR ci IN (
   SELECT to_clob(text) text
     FROM all_source
     WHERE owner = p_owner
       AND name = p_name
       AND type = p_type )
  LOOP       
 
    v_size := LENGTH( ci.text); 
    IF v_size + v_size_running > v_max_size
    THEN
      v_text := v_text || SUBSTR(ci.text, 1, v_max_size - v_size_running);
      EXIT;
    ELSE
      v_text := v_text || ci.text;
    END IF;
    v_size_running := v_size_running + v_size;
   
  END LOOP;
  
  RETURN v_text;
  
END;
/
