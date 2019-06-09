--@Autores: Andrés López Martínez y Carlos Gamaliel Morales Téllez
--@Fecha creación: 08/06/2019
--@Descripción: prueba del lob
!chmod 777 /tmp/bases/1.xml
!cp /tmp/bases/1.xml /tmp/bases/uno.txt 

declare
	v_xml clob;

begin  
	--Un clob siempre se tiene que inicializar, si no puede generar
	--la excepción ORA-06502: numeric or value error. 
	dbms_lob.createtemporary(v_xml,TRUE);
	dbms_output.put_line('181818181');
	sp_crea_clob(v_xml,'uno.txt');
	insert into factura(factura_id,fecha,importe,xml)
	values (factura_seq.nextval,sysdate,1000,v_xml);

end;
/
show errors