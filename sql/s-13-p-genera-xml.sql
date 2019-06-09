--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 08/06/2019
--@Descripción: Generación del documento xml para las facturas

create or replace procedure sp_genera_xml (
	p_usuario_id in number, p_fecha_inicio in date, p_fecha_fin in date
) is 

cursor cur_elementos_xml is
	select xmlagg(
      xmlelement("viaje",
          xmlforest(
            v.viaje_id as "id",
            v.importe as "importe",
            (v.importe+nvl(v.propina,0)) as "cobro"
          )
        )
    ) as viaje
  from viaje v
  join cliente c
  on v.USUARIO_ID = c.USUARIO_ID
  where c.USUARIO_ID=p_usuario_id
  and v.FECHA_STATUS 
    between p_fecha_inicio and p_fecha_fin;
	v_viaje varchar2(10000);
	v_archivo_xml UTL_FILE.FILE_TYPE; 
	v_nombre_xml varchar2(10) := p_usuario_id || '.xml';

begin

	v_archivo_xml := UTL_FILE.FOPEN('TMP_DIR',v_nombre_xml, 'W',3200);
	for row in cur_elementos_xml loop
		v_viaje := row.viaje.getStringVal();
		dbms_output.put_line('XML generado');
		
		UTL_FILE.PUT_LINE(v_archivo_xml,row.viaje.getStringVal());	
	end loop;
	UTL_FILE.FCLOSE(v_archivo_xml);

  exception
    --En caso de que la consulta no devuelva nada, se obtiene un error ORA-30625
    when Self_Is_Null then
      dbms_output.put_line('ERROR: No se pudo generar xml con los datos proporcionados');
    
end;
/
show errors



