--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 03/06/2019
--@Descripción: Conversión de archivo xml a clob

create or replace procedure sp_crea_clob (
  p_clob in out clob, p_nombre_archivo  in  varchar2
) is 
  
  l_bfile  BFILE;
  l_dest_offset number := 1;
  l_src_offset number := 1;
  l_bfile_csid number := 0;
  l_lang_context number := 0;
  l_warning number := 0;
begin
  l_bfile := bfilename('TMP_DIR', p_nombre_archivo);
  if dbms_lob.fileexists(l_bfile) = 1 and not 
      dbms_lob.isopen(l_bfile) = 1 then
        dbms_lob.open(l_bfile, dbms_lob.lob_readonly);
        DBMS_LOB.trim(p_clob, 0);

        DBMS_LOB.loadclobfromfile (
          dest_lob      => p_clob,
          src_bfile     => l_bfile,
          amount        => DBMS_LOB.lobmaxsize,
          dest_offset   => l_dest_offset,
          src_offset    => l_src_offset,
          bfile_csid    => l_bfile_csid ,
          lang_context  => l_lang_context,
          warning       => l_warning
        );
        DBMS_LOB.fileclose(l_bfile);
  else     
    dbms_output.put_line('ERROR: El archivo no existe');
  end if;

  
  exception
      
      when Value_Error then
        dbms_output.put_line('ERROR: El archivo es inválido');
      when others then
        dbms_output.put_line('Error no esperado');
        raise;    
  
end ;
/

show errors
 