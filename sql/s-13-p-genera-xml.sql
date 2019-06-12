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
            v.viaje_id as "viaje",
            v.importe_viaje as "importe"
          )
        )
    ) as viaje
  from v_factura v
  where v.USUARIO_ID=p_usuario_id
  and v.hora_inicio
    between p_fecha_inicio and p_fecha_fin;
	v_viaje varchar2(10000);
	v_archivo_xml UTL_FILE.FILE_TYPE; 
	v_nombre_xml varchar2(10) := p_usuario_id || '.xml';

xml_varchar varchar2(3000);
v_nombre usuario.nombre%type;
v_apellido_paterno usuario.apellido_paterno%type;

begin
  select nombre,apellido_paterno
  into v_nombre,v_apellido_paterno
  from usuario
  where usuario_id = p_usuario_id;


	v_archivo_xml := UTL_FILE.FOPEN('TMP_DIR',v_nombre_xml, 'W',3200);
	xml_varchar := '<usuario><nombre>'
                  ||v_nombre
                  ||'</nombre>'
                  ||'<apellido_paterno>'
                  ||v_apellido_paterno
                  ||'</apellido_paterno>';
  for row in cur_elementos_xml loop
		v_viaje := row.viaje.getStringVal();
		dbms_output.put_line('XML generado');
		
		xml_varchar := xml_varchar || row.viaje.getStringVal();
	end loop;
  UTL_FILE.PUT_LINE(v_archivo_xml, xml_varchar || '</usuario>');
	UTL_FILE.FCLOSE(v_archivo_xml);

  exception
    --En caso de que la consulta no devuelva nada, se obtiene un error ORA-30625
    when Self_Is_Null then
      dbms_output.put_line('ERROR: No se pudo generar xml con los datos proporcionados');
    
end;
/
show errors



