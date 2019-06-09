create or replace procedure file_to_clob (
  p_clob in out nocopy clob, p_nombre_archivo  in  varchar2
) is 
  
  l_bfile  BFILE;
  l_dest_offset number := 1;
  l_src_offset number := 1;
  l_bfile_csid number := 0;
  l_lang_context number := 0;
  l_warning number := 0;
begin
  l_bfile := bfilename('TMP_DIR', p_nombre_archivo);
  DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly);
  DBMS_LOB.trim(p_clob, 0);

  DBMS_LOB.loadclobfromfile (
    dest_lob      => p_clob,
    src_bfile     => l_bfile,
    amount        => DBMS_LOB.lobmaxsize,
    dest_offset   => l_dest_offset,
    src_offset    => l_src_offset,
    bfile_csid    => l_bfile_csid ,
    lang_context  => l_lang_context,
    warning       => l_warning);
  DBMS_LOB.fileclose(l_bfile);

end ;
/

show errors

exec 