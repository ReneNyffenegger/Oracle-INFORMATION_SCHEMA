create or replace function information_schema.get_proc_text(
  p_owner in varchar2,
  p_name  in varchar2,
  p_type  in varchar2,
  p_size  in pls_integer default 32767 ) 
return clob
as
  v_text         CLOB;
  v_max_size     PLS_INTEGER;
  v_size         PLS_INTEGER := 0;
  v_size_running PLS_INTEGER := 0;
begin
 
  if p_size is null or p_size < 0 /* or p_size > 32767 */ then
     v_max_size := 32767;
  else
     v_max_size := p_size;
  end if;
   
  for ci in (
   select
     to_clob(text) text
   from
     all_source
   where
     owner = p_owner and
     name  = p_name  and
     type  = p_type 
  )
  loop       
 
    v_size := length(ci.text); 

    if v_size + v_size_running > v_max_size then
       v_text := v_text || substr(ci.text, 1, v_max_size - v_size_running);
       exit;
    else
       v_text := v_text || ci.text;
    end if;

    v_size_running := v_size_running + v_size;
   
  end loop;
  
  return v_text;
  
end;
/
